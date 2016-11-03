require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_duration' do
    it 'has correct format' do
      expect(helper.format_duration(0)).to eq('00:00:00')
      expect(helper.format_duration(1)).to eq('00:00:01')
      expect(helper.format_duration(1.second + 2.minutes + 3.hours)).to eq('03:02:01')
    end
    
    it 'returns default value for wrong input' do
      expect(helper.format_duration('test')).to eq('00:00:00')
    end
  end
end
