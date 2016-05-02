require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
 
  describe 'POST #create' do 
    before(:each) do 
      @user = FactoryGirl.attributes_for :user
      post :create, @user, format: :json 
    end 

    context 'when a user successfully creates an account' do 
      it 'should return the user details in JSON format' do 
        user_response = json_response 

        expect(user_response[:email]).to eq @user[:email]
      end 

      it { should respond_with 201 }
    end

    context 'when a user account is not created' do 
      before(:each) do 
        @invalid_data = {email: 'james@james', password: '1234'}
        post :create, @invalid_data
      end 

      it 'returns error message in JSON' do 
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end   
  end  
end  
