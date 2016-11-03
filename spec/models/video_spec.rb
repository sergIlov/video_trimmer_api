require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'fields' do
    it 'has file' do
      expect(described_class).to have_fields(:file)
    end
  end
  
  describe 'assotiations' do
    it 'belongs to user' do
      expect(described_class).to belong_to(:user)
    end
    
    it 'has many tasks' do
      expect(described_class).to have_many(:tasks)
    end
  end

  describe 'validations' do
    it 'validates file' do
      expect(described_class).to validate_presence_of(:file)
    end
  end
end
