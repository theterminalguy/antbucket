FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "name#{n}" }
    bucket_list

    trait :id do
      bucket_list_id 4
    end
  end
end
