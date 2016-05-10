module Api
  module V1
    class ItemsController < ApplicationController
      before_action :authenticate
      before_action :set_item, only: [:show, :update, :destroy]

      # GET /items
      def index
        @items = Item.all
        if @items.empty?
          render json: { message: 'item is empty' }
        else
          render json: @items
        end
      end

      # GET /items/1
      def show
        render json: @item
      end

      # POST /items
      def create
        @item = Item.new(item_params)

        if @item.save
          render json: @item, status: :created
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /items/1
      def update
        @item = Item.find(params[:id])

        if @item.update(item_params)
          render json: @item
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # DELETE /items/1
      def destroy
        @item.destroy

        render json: { message: 'deleted successfully' }
      end

      private

      def set_item
        @item = Item.find(params[:id])
      end

      def item_params
        params.permit(:bucket_list_id, :name, :done, :default)
      end
    end
  end
end
