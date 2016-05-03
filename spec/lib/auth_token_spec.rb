require 'rails_helper'

RSpec.describe AuthToken do
  before(:each) do 
    @token = {user_id: 1}
  end

  describe '#issue' do 
    it do
      allow(AuthToken).to receive(:issue).with(@token).and_return(true)
    end 
  end 

  describe '#decode' do 
    it do 
      allow(AuthToken).to receive(:decode).with(@token).and_return(true)
    end 
  end 
end
