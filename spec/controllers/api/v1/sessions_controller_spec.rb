require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  before(:each) do
    @user = create :user
  end

  describe 'POST #create' do
    context 'when the credentials are correct' do
      before(:each) do
        @credentials = { email: @user.email, password: '1234567' }
      end

      it "returns the user's email and token if login successfully" do
        post :create, @credentials
        expect(json_response.keys).to include(:user_email, :token)
        expect(json_response[:user_email]).to eq @user.email
        expect(json_response[:token]).to_not be_empty
        expect(response.status).to eq 200
      end
    end

    context 'when the credentials are incorrect' do
      before(:each) do
        @credentials = { email: @user.email, password: '1234' }
      end

      it 'returns a hash with key errors' do
        post :create, @credentials
        expect(json_response).to include(:errors)
        expect(json_response[:errors]).to eq 'invalid user name or password'
        expect(response.status).to eq 422
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      stub_curent_user(@user)
      delete :destroy, nil, token: token
    end

    context 'when users signs out successfully' do
      it 'returns a detailed error message' do
        expect(json_response[:message]).to eq 'logout successfully'
        expect(response.status).to eq 200
      end
    end
  end
end
