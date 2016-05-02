require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  before(:each) do
      @user = FactoryGirl.create(:user)
    end

  describe 'POST #create' do 
    context 'when the credentials are correct' do 
      before(:each) do 
        credentials = { email: @user.email, password:'1234567' }
        post :create, credentials
      end 

      it "returns the user's email and token if login successfully" do 
        expect(json_response.keys).to include(:user_email, :token) 
      end 
      
      it 'email should be valid' do 
        expect(json_response[:user_email]).to eq @user.email 
      end

      it 'returns a valid token' do 
        expect(json_response[:token]).to_not be_empty 
      end  

      it { should respond_with 200 }
    end

    context 'when the credentials are incorrect' do 
      before(:each) do 
        credentials = {email: @user.email, password:'1234'}
        post :create, credentials
      end 

      it 'returns a hash with key errors' do 
        expect(json_response).to include(:errors)
      end 

      it 'returns a detailed error message' do 
        expect(json_response[:errors]).to eq 'invalid user name or password'
      end 
    end 
  end

  describe 'DELETE #destroy' do 
    before(:each) do 
      allow(controller).to receive(:current_user).and_return(@user)
      delete :destroy, nil, { token: token }
    end 

    context 'when users signs out successfully' do 
      it 'returns a detailed error message' do 
        expect(json_response[:message]).to eq 'signed out successfully'
      end 
      it { should respond_with 410 }
    end 
  end 
end 
