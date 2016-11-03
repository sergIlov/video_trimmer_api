FactoryGirl.define do
  start_time = Random.rand(100)
  factory :task do
    start_time start_time
    end_time Random.rand(100) + start_time
  end
end
