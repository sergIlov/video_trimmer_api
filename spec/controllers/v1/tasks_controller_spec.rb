require 'rails_helper'

RSpec.describe V1::TasksController, type: :controller do
  render_views
  
  context 'not authorized' do
    describe 'GET index' do
      it 'has a 401 status code' do
        get :index
        expect(response).to be_unauthorized
      end
    end
    
    describe 'POST create' do
      it 'has a 401 status code' do
        post :create
        expect(response).to be_unauthorized
      end
    end
    
    describe 'GET show' do
      it 'has a 401 status code' do
        get :show, params: { id: '', format: :json }
        expect(response).to be_unauthorized
      end
    end

    describe 'GET restart' do
      it 'has a 401 status code' do
        get :restart, params: { id: '', format: :json }
        expect(response).to be_unauthorized
      end
    end
  end

  context 'authorized' do
    let(:user) do
      FactoryGirl.create(:user).tap do |user|
        video = FactoryGirl.build(:video, user: user)
        user.tasks = [FactoryGirl.build(:task, video: video), FactoryGirl.build(:task, video: video)]
      end
    end
    before do
      token = ActionController::HttpAuthentication::Token.encode_credentials(user.token)
      request.headers['HTTP_AUTHORIZATION'] = token
    end
  
    describe 'GET index' do
      before { get :index, format: :json }
      
      it 'has a 200 status code' do
        expect(response).to be_success
      end
  
      it 'assigns @tasks' do
        expect(assigns(:tasks)).to eq(user.tasks)
      end

      it 'renders correct json' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.size).to be(2)
        expect(parsed_response.first.keys).to eq(%w(id created_at original_video_id duration state))
      end
    end

    describe 'GET show' do
      context 'valid params' do
        let(:task) { user.tasks.first }
        before { get :show, params: { id: task.id }, format: :json }
    
        it 'has a 200 status code' do
          expect(response).to be_success
        end
    
        it 'assigns @task' do
          expect(assigns(:task)).to eq(task)
        end
    
        it 'renders correct json' do
          parsed_response = JSON.parse(response.body)
          expect(parsed_response.keys).to eq(%w(id created_at original_video_id duration state))
        end
      end
  
      context 'invalid params' do
        it 'renders json with error' do
          get :show, params: { id: '' }, format: :json
          parsed_response = JSON.parse(response.body)
          expect(parsed_response).to have_key('error')
        end
      end
    end

    describe 'POST create' do
      context 'invalid params' do
        before { post :create, params: {}, format: :json }
    
        it 'has a 200 status code' do
          expect(response).to be_success
        end
    
        it 'renders validation error' do
          parsed_response = JSON.parse(response.body)
          expect(parsed_response).to have_key('validation_errors')
        end
      end
  
      context 'valid params' do
        let(:video) { user.videos.first }
        subject { post :create, params: { end_time: Random.rand(100).next, video_id: video.id }, format: :json }
    
        it 'creates task' do
          expect { subject }.to change { Task.count }
        end
    
        it 'redirects to show' do
          expect(subject).to redirect_to(assigns(:task))
        end
        
        it 'assigns task to user' do
          subject
          expect(assigns(:task).user).to eq(user)
        end
      end
    end
    
    describe 'GET restart' do
      context 'unexisting id' do
        it 'has a 404 status code for wrong id' do
          get :restart, params: { id: '' }, format: :json
          expect(response).to be_not_found
        end
      end
        
      context 'existing id' do
        let(:task) { user.tasks.first }

        it 'allows restarting failed task' do
          task.update_attributes(state: :failed)
          get :restart, params: { id: task }, format: :json
          
          expect(response).to redirect_to(task)
        end
        
        it 'disallows restarting unfailed task' do
          get :restart, params: { id: task }, format: :json
          parsed_response = JSON.parse(response.body)
          expect(parsed_response).to have_key('error')
        end
      end
    end
  end
end
