require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  let(:user) { FactoryGirl.attributes_for :user }

  describe 'POST #create' do
    context 'when a user successfully creates an account' do
      it 'should return the user details in JSON format' do
        post :create, user, format: :json
        user_response = json_response[:user_data]
        expect(user_response[:email]).to eq user[:email]
        expect(response.status).to eq 200
      end
    end

    context 'when a user account is not created' do
      it 'returns error message in JSON' do
        invalid_data = { email: 'james', password: '1234' }
        post :create, invalid_data
        expect(json_response).to have_key(:errors)
        errors = json_response[:errors]
        expect(errors[:email]).to eq msg_error.invalid
        expect(errors[:password]).to eq msg_error.password 
        expect(response.status).to eq 422
      end
    end
  end
end
