require 'rails_helper'

RSpec.describe BucketList, type: :model do
  subject { FactoryGirl.create :bucket_list }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should belong_to :user }
  it { should be_valid }
end
