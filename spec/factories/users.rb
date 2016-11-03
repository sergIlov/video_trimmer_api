FactoryGirl.define do
  factory :user do
    token SecureRandom.hex(20)
  end
end
