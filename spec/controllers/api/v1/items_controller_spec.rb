require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  before(:each) do
    @user = create(:user)
    stub_curent_user(@user)
    stub_authenticate
  end

  describe 'GET #index' do
    context 'when item is empty' do
      before(:each) do
        @item = build :item
      end

      it 'returns detailed message' do
        get :index, bucket_list_id: @item.bucket_list_id
        expect(json_response[:message]).to eq 'item is empty'
      end
    end

    context 'when item is not empty' do
      before(:each) do
        @item = create :item
      end

      it 'returns the appropriate record' do
        get :index, bucket_list_id: @item.bucket_list_id
        expect(json_response.count).to eq 1
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #show' do
    context 'when given an id' do
      before(:each) do
        @item = create :item
      end

      it 'returns the record with the id' do
        get :show, bucket_list_id: @item.bucket_list_id, id: @item.id
        item_data = json_response[:item]
        expect(item_data[:id]).to eq @item.id
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST #create' do
    context 'when valid data is given' do
      before(:each) do
        @item = attributes_for(:item, :id)
      end

      it 'returns the record just created' do
        post :create, @item
        item_data = json_response[:item]
        expect(item_data[:name]).to eq @item[:name]
        expect(response.status).to eq 201
      end
    end

    context 'when invalid data is given' do
      before(:each) do
        @item = attributes_for(:item, :id)
        @item[:name] = nil
      end

      it 'returns detailed error message' do
        post :create, @item
        expect(json_response[:name]).to eq ["can't be blank"]
        expect(response.status).to eq 422
      end
    end
  end

  describe 'PUT #update' do
    context 'when valid' do
      before(:each) do
        @item = create :item
        @item.name = 'A new name'
      end

      it 'should update the record' do
        put :update, bucket_list_id: @item.bucket_list_id,
                     id: @item.id,
                     name: @item.name
        item_data = json_response[:item]
        expect(item_data[:name]).to eq @item.name
        expect(response.status).to eq 200
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when valid' do
      before(:each) do
        @item = create :item
      end

      it do
        delete :destroy, bucket_list_id: @item.bucket_list_id,
                         id: @item.id,
                         name: @item.name
        expect(response.status).to eq 200
      end
    end
  end
end
