require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  before(:each) do 
    allow(controller).to receive(:authenticate).and_return(true) 
  end

  describe 'GET #index' do 
    context 'when item is empty' do 
      before(:each) do 
        @item = FactoryGirl.build :item
        get :index, {bucket_list_id: @item.bucket_list_id}
      end 

      it 'returns detailed message' do  
        expect(json_response[:message]).to eq 'item is empty' 
      end
    end

    context 'when item is not empty' do 
      before(:each) do 
        @item = FactoryGirl.create :item 
        get :index, {bucket_list_id: @item.bucket_list_id}
      end 

      it 'returns the appropriate record' do 
        expect(json_response.count).to eq 1 
      end 

      it {should respond_with 200}
    end 
  end 

  describe 'GET #show' do 
    context 'when given an id' do 
      before(:each) do 
        @item = FactoryGirl.create :item 
        get :show, {bucket_list_id: @item.bucket_list_id, id: @item.id}
      end 

      it 'returns the record with the id' do 
        expect(json_response[:id]).to eq @item.id 
      end 

      it {should respond_with 200}
    end 
  end 

  describe 'POST #create' do 
    context 'when valid data is given' do 
      before(:each) do 
        @item = FactoryGirl.attributes_for(:item, :id)
        post :create, @item 
      end 

      it 'returns the record just created' do 
        expect(json_response[:name]).to eq @item[:name]
      end

      it {should respond_with 201}
    end

    context 'when invalid data is given' do 
      before(:each) do 
        @item = FactoryGirl.attributes_for(:item, :id)
        @item[:name] = nil 
        post :create, @item 
      end 

      it 'returns detailed error message' do 
        expect(json_response[:name]).to eq ["can't be blank"]
      end 

      it {should respond_with 422}
    end  
  end 

  describe 'PUT #update' do 
    context 'when valid' do
      before(:each) do 
        @item = FactoryGirl.create :item 
        @item.name = 'A new name'
        put :update, {
                  bucket_list_id: @item.bucket_list_id,
                  id: @item.id, 
                  name: @item.name
                }
      end  

      it 'should update the record' do 
        expect(json_response[:name]).to eq @item.name 
      end 

      it {should respond_with 200}
    end 
  end 

  describe 'DELETE #destroy' do 
    context 'when valid' do 
      before(:each) do 
        @item = FactoryGirl.create :item 
        delete :destroy, {
                  bucket_list_id: @item.bucket_list_id,
                  id: @item.id, 
                  name: @item.name
                }
      end 

      it { should respond_with 410}
    end 
  end 
end
