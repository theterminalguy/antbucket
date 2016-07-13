require 'rails_helper'

RSpec.describe 'BucketLists', type: :request do
  let(:user) { create(:user) }

  before(:each) do
    stub_curent_user(user)
    stub_authenticate
  end

  describe 'GET /index' do
    context 'when a user has no bucket lists' do
      it 'returns a total record count of zero' do
        get api_v1_bucket_lists_path
        expect(json_response[:message]).to eq msg_success.empty
      end
    end

    context 'when a user has bucket lists' do
      it 'returns all bucket_list belonging to the user' do
        3.times { create(:bucket_list, user: user) }
        get api_v1_bucket_lists_path
        expect(json_response.count).to eq 3
        expect(response.status).to eq 200
      end
    end

    context 'when given a name as a search parameter' do
      it 'returns the appropriate record' do
        bucket_list = create(:bucket_list, user: user)
        get api_v1_bucket_lists_path, q: bucket_list.name
        user_data = json_response[:bucket_list][0]
        expect(user_data[:name]).to eq bucket_list.name
        expect(response.status).to eq 200
      end
    end

    context 'when given page and limit parameter' do
      it 'returns the appropriate record based on the parameter' do
        2.times { create(:bucket_list, user: user) }
        get api_v1_bucket_lists_path, page: 1, limit: 1
        expect(json_response[:total_records]).to eq 2
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /show' do
    context 'when given an id for a record' do
      it 'should return the record with the appropriate id' do
        bucket_list = create(:bucket_list, user: user)
        get api_v1_bucket_list_path(bucket_list.id)
        user_data = json_response[:bucket_list]
        expect(user_data[:id]).to eq bucket_list.id
        expect(response.status).to eq 200
      end
    end

    context 'when given an invalid id for a record' do
      it 'should return detailed not found message' do
        get api_v1_bucket_list_path(1000)
        expect(
          json_response[:error]
        ).to eq msg_error.not_found('BucketList', '1000')
      end
    end

    context 'when a user tries to access record belonging to another user' do
      it 'returns an error message' do
        bucket_list = create(:bucket_list)
        get api_v1_bucket_list_path(bucket_list.id)
        expect(json_response[:message]).to eq msg_error.denial
        expect(response.status).to eq 403
      end
    end
  end

  describe 'POST /create' do
    context 'when all attributes are provided' do
      it 'should not save' do
        bucket_list = attributes_for(:bucket_list, user: @user)
        post api_v1_bucket_lists_path, bucket_list
        expect(response.status).to eq 201
      end
    end

    context 'when name is not given' do
      it 'should return an error message' do
        bucket_list = { user: user, name: nil }
        post api_v1_bucket_lists_path, bucket_list
        expect(json_response[:name]).to eq msg_error.blank
      end
    end
  end

  describe 'PUT /update' do
    context 'when all attributes are provided' do
      it 'should update successfully' do
        bucket_list = create(:bucket_list, user: user)
        put api_v1_bucket_list_path(bucket_list.id), name: 'A new name'
        expect(response.status).to eq 200
      end
    end

    context 'when name is not given' do
      it 'should fail to update' do
        bucket_list = create(:bucket_list, user: user)
        put api_v1_bucket_list_path(bucket_list.id), name: nil
        expect(json_response[:name]).to eq msg_error.blank
        expect(response.status).to eq 422
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when valid id is provided' do
      it 'should delete successfully' do
        bucket_list = create(:bucket_list, user: user)
        delete api_v1_bucket_list_path(bucket_list.id)
        expect(response.status).to eq 200
      end
    end

    context 'when invalid id is provided' do
      it 'should fail to delete and return a detailed message' do
        bucket_list = create(:bucket_list, user: user)

        delete api_v1_bucket_list_path(-1)
        expect(
          json_response[:error]
        ).to eq msg_error.not_found('BucketList', '-1')
        expect(response.status).to eq 404
      end
    end
  end
end
