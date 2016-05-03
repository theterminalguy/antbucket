FactoryGirl.define do
  sequence :name do |n|
    "Bucket_list#{n}"
  end
    
  factory :bucket_list do
    user
    name
  end
end
