FactoryGirl.define do
  factory :bucket_list do
    sequence(:name) { |n| "name#{n}" }
    user
  end
end
