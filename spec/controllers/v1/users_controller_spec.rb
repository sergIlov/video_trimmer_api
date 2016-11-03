require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe 'POST create' do
    it 'has a 200 status code' do
      post :create
      expect(response).to be_success
    end
    
    it 'change users count' do
      expect { post :create }.to change { User.count }
    end
    
    it 'renders token' do
      post :create
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to have_key('token')
    end
  end
end
