require 'rails_helper'

RSpec.describe Api::V1::BucketListsController, type: :controller do
  before(:each) do
    @user = create(:user)
    stub_curent_user(@user)
    stub_authenticate
  end

  describe 'GET #index' do
    context 'when a user has no bucket lists' do
      it 'returns a total record count of zero' do
        get :index
        expect(json_response[:message]).to eq 'bucket list is empty'
      end
    end

    context 'when a user has bucket lists' do
      before(:each) do
        3.times do
          create(:bucket_list, user: @user)
        end
      end

      it 'returns all bucket_list belonging to the user' do
        get :index
        expect(json_response.count).to eq 3
        expect(response.status).to eq 200
      end
    end

    context 'when given a name as a search parameter' do
      before(:each) do
        @bucket_list = create(:bucket_list, user: @user)
      end

      it 'returns the appropriate record' do
        get :index, { q: @bucket_list.name }, token: token
        user_data = json_response[:bucket_list][0]
        expect(user_data[:name]).to eq @bucket_list.name
        expect(response.status).to eq 200
      end
    end

    context 'when given page and limit parameter' do
      before(:each) do
        2.times do
          create(:bucket_list, user: @user)
        end
      end

      it 'returns the appropriate record based on the parameter' do
        get :index, { page: 1, limit: 1 }, token: token
        expect(json_response[:total_records]).to eq 2
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #show' do
    context 'when given an id for a record' do
      before(:each) do
        @bucket_list = create(:bucket_list, user: @user)
      end

      it 'returns the record with the appropriate id' do
        get :show, { id: @bucket_list.id }, token: token
        user_data = json_response[:bucket_list]
        expect(user_data[:id]).to eq @bucket_list.id
        expect(response.status).to eq 200
      end
    end

    context 'when given an invalid id for a record' do
      it 'raises ActiveRecord::RecordNotFound Exception' do
        get:show, { id: 1000 }, token: token
        expect(
          json_response[:error]
        ).to eq "Couldn't find BucketList with 'id'=1000"
      end
    end

    context 'when a user tries to access record belonging to another user' do
      before(:each) do
        @bucket_list = create(:bucket_list)
      end

      it 'returns an error message' do
        get :show, { id: @bucket_list.id }, token: token
        expect(json_response[:message]).to eq 'unauthorized access'
        expect(response.status).to eq 403
      end
    end
  end

  describe 'POST #create' do
    context 'when a valid attributes are provided' do
      before(:each) do
        @bucket_list = attributes_for(:bucket_list, user: @user)
      end

      it 'should not save' do
        post :create, @bucket_list, token: token
        expect(response.status).to eq 201
      end
    end

    context 'when invalid attributes are provided' do
      before(:each) do
        @bucket_list = { user: @user, name: '' }
      end

      it 'should return an error message' do
        post :create, @bucket_list, token: token
        expect(json_response[:name]).to eq ["can't be blank"]
      end
    end
  end

  describe 'PUT #update' do
    context 'when valid' do
      before(:each) do
        @bucket_list = create(:bucket_list, user: @user)
      end
      it do
        put :update, { id: @bucket_list.id, name: 'A new name' }, token: token
        expect(response.status).to eq 200
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when valid' do
      before(:each) do
        @bucket_list = create(:bucket_list, user: @user)
      end

      it do
        delete :destroy, { id: @bucket_list.id }, token: token
        expect(response.status).to eq 200
      end
    end
  end
end
