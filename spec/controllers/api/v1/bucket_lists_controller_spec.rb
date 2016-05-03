require 'rails_helper'

RSpec.describe Api::V1::BucketListsController, type: :controller do

  describe '#check_owner' do 
    it 'validates the presence check_owner' do 
      allow(controller).to receive(:check_owner).and_return(true)
      expect(controller.send(:check_owner)).to eq true 
    end 
  end 
  

  before(:each) do 
    @user = FactoryGirl.create :user
    allow(controller).to receive(:current_user).and_return(@user) 
    allow(controller).to receive(:authenticate).and_return(true) 
  end 

  describe 'GET #index' do 
    context 'when a user has no bucket lists' do 
      it 'returns a total record count of zero' do 
        get :index, nil, {token: token}
        expect(json_response[:total]).to eq 0 
      end
    end 

    context 'when a user has bucket lists' do 
      before(:each) do 
        3.times do 
          FactoryGirl.create :bucket_list, user: @user 
        end 
        get :index, nil, { token: token }
      end 
  
      it 'returns all bucket_list belonging to the user' do 
        expect(json_response[:total]).to eq 3
      end 

      it {should respond_with 200 }
    end 

    context 'when given a name as a search parameter' do
      before(:each) do 
        @bucket_list = FactoryGirl.create :bucket_list, user: @user  
        get :index, {q: @bucket_list.name}, {token: token}
      end  

      it 'returns the appropriate record' do  
        expect(json_response[:name]).to eq @bucket_list.name 
      end 

      it {should respond_with 200 }
    end 

    context 'when given page and limit parameter' do 
      before(:each) do 
        2.times do 
          FactoryGirl.create :bucket_list, user: @user 
        end 
        get :index, {page: 1, limit: 1}, { token: token }
      end 

      it 'returns the appropriate record based on the parameter' do
        expect(json_response[:total]).to eq 2 
      end 

      it {should respond_with 200 }
    end 
  end 


  describe 'GET #show' do 
    context 'when given an id for a record' do
      before(:each) do 
        @bucket_list = FactoryGirl.create :bucket_list, user: @user  
        get :show, {id: @bucket_list.id}, {token: token}
      end

      it 'returns the record with the appropriate id' do  
        expect(json_response[:id]).to eq @bucket_list.id 
      end 

      it {should respond_with 200 }
    end 

    context 'when a user tries to access record belonging to another user' do 
      before(:each) do 
        @bucket_list = FactoryGirl.create :bucket_list
        get :show, {id: @bucket_list.id}, {token: token}
      end 

      it 'returns an error message' do 
        expect(json_response[:message]).to eq 'unauthorized access'
      end

      it {should respond_with 403 }
    end 
  end

  describe 'POST #create' do 
    context 'when a valid attributes are provided' do 
      before(:each) do 
        @bucket_list = FactoryGirl.attributes_for :bucket_list, user: @user 
        post :create, @bucket_list, {token: token}
      end 
      it { should respond_with 201 }
    end 

    context 'when invalid attributes are provided' do 
      before(:each) do 
        @bucket_list = {user: @user, name: '' }
        post :create, @bucket_list, {token: token}
      end

      it 'should return an error message' do 
        expect(json_response[:name]).to eq ["can't be blank"]
      end 
    end 
  end 

  describe 'PUT #update' do 
    context 'when valid' do
      before(:each) do 
        @bucket_list = FactoryGirl.create :bucket_list, user: @user 
        put :update, {id:@bucket_list.id, name: 'A new name'}, {token:token} 
      end  
      it {should respond_with 200}
    end 
  end 

  describe 'DELETE #destroy' do 
    context 'when valid' do 
      before(:each) do 
        @bucket_list = FactoryGirl.create :bucket_list, user: @user 
        delete :destroy, {id: @bucket_list.id}, {token: token}
      end 

      it { should respond_with 410}
    end 
  end 
end
