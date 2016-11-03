require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'fields' do
    it 'has token' do
      expect(described_class).to have_fields(:start_time, :end_time, :state)
    end
  end
  
  describe 'assotiations' do
    it 'belongs to user' do
      expect(described_class).to belong_to(:user)
    end
    
    it 'belongs to video' do
      expect(described_class).to belong_to(:video)
    end
  end

  describe 'validations' do
    it 'validates start_time' do
      expect(described_class).to validate_numericality_of(:start_time).to_allow(greater_than_or_equal_to: 0)
      
    end

    it 'validates end_time' do
      expect(described_class).to validate_presence_of(:end_time)
      expect(described_class).to validate_numericality_of(:end_time)
    end
  end
end
