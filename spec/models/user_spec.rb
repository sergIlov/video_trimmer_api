require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'fields' do
    it 'has token' do
      expect(described_class).to have_fields(:token)
    end
  end
  
  describe '#generate_token' do
    it 'should assign token' do
      user = User.create
      expect(user.token).not_to be_empty
    end
  end
  
  describe 'assotiations' do
    it 'has many videos' do
      expect(described_class).to have_many(:videos).with_dependent(:destroy)
    end
    
    it 'has many tasks' do
      expect(described_class).to have_many(:tasks).with_dependent(:destroy)
    end
  end
end
