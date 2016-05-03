require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.create :user }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_value('xxx@domain.com').for :email }

  it { should have_many :bucket_lists }

  it { should be_valid }
end
