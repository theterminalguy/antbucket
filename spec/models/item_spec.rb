require 'rails_helper'

RSpec.describe Item, type: :model do
  subject { FactoryGirl.create :item }

  it { should validate_presence_of :name }
  
  it { should belong_to :bucket_list }

  it { should be_valid }
end
