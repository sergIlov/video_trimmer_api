require 'rails_helper'

RSpec.describe V1::VideosController do
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
  end

  context 'authorized' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      token = ActionController::HttpAuthentication::Token.encode_credentials(user.token)
      request.headers['HTTP_AUTHORIZATION'] = token
    end
    
    describe 'GET index' do
      before do
        FactoryGirl.create(:video, user: user)
        FactoryGirl.create(:video, user: user)
        get :index, format: :json
      end
      
      it 'has a 200 status code' do
        expect(response).to be_success
      end
      
      it 'assigns @videos' do
        expect(assigns(:videos)).to eq(user.videos)
      end
      
      it 'renders correct json' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.size).to be(2)
        expect(parsed_response.first.keys).to eq(%w(id url created_at))
      end
    end
    
    describe 'GET show' do
      context 'valid params' do
        let(:video) { FactoryGirl.create(:video, user: user) }
        before { get :show, params: { id: video.id }, format: :json }
  
        it 'has a 200 status code' do
          expect(response).to be_success
        end
  
        it 'assigns @video' do
          expect(assigns(:video)).to eq(video)
        end
  
        it 'renders correct json' do
          parsed_response = JSON.parse(response.body)
          expect(parsed_response.keys).to eq(%w(id url created_at))
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
        subject { post :create, params: { file: file }, format: :json }
        let(:file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.avi'), 'video/mpeg') }
        
        it 'creates video' do
          expect { subject }.to change { Video.count }
        end
        
        it 'redirects to show' do
          expect(subject).to redirect_to(assigns(:video))
        end

        it 'assigns video to user' do
          subject
          expect(assigns(:video).user).to eq(user)
        end
      end
    end
  end
end