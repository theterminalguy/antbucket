module Api
  module V1
    class ItemsController < ApplicationController
      before_action :authenticate
      before_action :set_bucket, only: [:index, :show, :update, :destroy]
      before_action :set_item, only: [:show, :update, :destroy]

      # GET /items

      def index
        @items = @bucket_list.items
        if @items.empty?
          render json: { message: success.empty }
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
        if @item.update(item_params)
          render json: @item
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # DELETE /items/1
      def destroy
        @item.destroy

        render json: { message: success.deleted }
      end

      private

      def set_bucket
        @bucket_list = current_user.bucket_lists.find(params[:bucket_list_id])
      end

      def set_item
        @item = @bucket_list.items.find(params[:id])
      end

      def item_params
        params.permit(:bucket_list_id, :name, :done, :default)
      end
    end
  end
end
