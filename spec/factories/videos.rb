FactoryGirl.define do
  factory :video do
    file Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/fixtures/files/test.avi')), 'video/mpeg')
  end
end
