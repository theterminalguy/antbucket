require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  let(:user) {create(:user)}

  before(:each) do
    stub_curent_user(user)
    stub_authenticate
  end

  describe 'GET #index' do
    context 'when item is empty' do
      it 'should return success error message' do
        item = build :item
        get :index, bucket_list_id: item.bucket_list_id
        expect(json_response[:message]).to eq msg_success.empty
        expect(response.status).to eq 200 
      end
    end

    context 'when item is not empty' do
      it 'should return record belonging to the user' do
        item = create :item
        get :index, bucket_list_id: item.bucket_list_id
        expect(json_response.count).to eq 1
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #show' do
    context 'when given a valid id' do
      it 'returns the record with the id' do
        item = create :item
        get :show, bucket_list_id: item.bucket_list_id, id: item.id
        item_data = json_response[:item]
        expect(item_data[:id]).to eq item.id
        expect(response.status).to eq 200
      end
    end

    context 'when given an invalid id' do
      it 'should return detailed not found message' do
        item = create :item
        get :show, bucket_list_id: item.bucket_list_id, id: -1
        expect(
          json_response[:error]
        ).to eq msg_error.not_found('Item', '-1')
        expect(response.status).to eq 404
      end
    end
  end

  describe 'POST #create' do
    context 'when all attributes are provided' do
      it 'returns the record just created' do
        item = attributes_for(:item, :id)
        post :create, item
        item_data = json_response[:item]
        expect(item_data[:name]).to eq item[:name]
        expect(response.status).to eq 201
      end
    end

    context 'when name is not given' do
      it 'returns detailed error message' do
        item = attributes_for(:item, :id)
        item[:name] = nil
        post :create, item
        expect(json_response[:name]).to eq msg_error.blank 
        expect(response.status).to eq 422
      end
    end
  end

  describe 'PUT #update' do
    context 'when all attributes are provided' do
      it 'should update the record' do
        item = create :item
        item.name = 'A new name'
        put :update, bucket_list_id: item.bucket_list_id,
                     id: item.id,
                     name: item.name
        item_data = json_response[:item]
        expect(item_data[:name]).to eq item.name
        expect(response.status).to eq 200
      end
    end


    context 'when name is not given' do
      it 'should fail to update the record' do
        item = create :item
        item.name = nil 
        put :update, bucket_list_id: item.bucket_list_id,
                     id: item.id,
                     name: item.name
        expect(json_response[:name]).to eq msg_error.blank 
        expect(response.status).to eq 422
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when valid id is provided' do
      it 'should delete successfully' do
        item = create :item
        delete :destroy, bucket_list_id: item.bucket_list_id,
                         id: item.id
        expect(response.status).to eq 200
      end
    end

    context 'when an invalid id is provided' do
      it 'should fail to delete and return a detailed message' do
        item = create :item
        delete :destroy, bucket_list_id: item.bucket_list_id,
                         id: -1
        expect(
          json_response[:error]
        ).to eq msg_error.not_found('Item', '-1')
        expect(response.status).to eq 404
      end
    end
  end
end
