module Api
  module V1
    class BucketListsController < ApplicationController
      before_action :authenticate
      before_action :set_bucket_list, only: [:show, :update, :destroy]
      before_action :check_owner, only: [:show, :update, :destroy]

      # GET /bucket_lists
      def index
        bucket_lists = current_user.bucket_lists
        result = Paginator.new(params).paginate(bucket_lists, [:id, :name])
        if bucket_lists.empty?
          render json: { message: success.empty }
        else
          render json: result
        end
      end

      # GET /bucket_lists/1
      def show
        render json: @bucket_list
      end

      # POST /bucket_lists
      def create
        @bucket_list = current_user.bucket_lists.new(bucket_list_params)
        if @bucket_list.save
          render json: @bucket_list, status: :created
        else
          render json: @bucket_list.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /bucket_lists/1
      def update
        if @bucket_list.update(bucket_list_params)
          render json: @bucket_list
        else
          render json: @bucket_list.errors, status: :unprocessable_entity
        end
      end

      # DELETE /bucket_lists/1
      def destroy
        @bucket_list.destroy
        render json: { message: success.deleted }
      end

      private

      def set_bucket_list
        @bucket_list = BucketList.find(params[:id])
      end

      def check_owner
        if current_user.id != @bucket_list.user_id
          render json: { message: error.denial }, status: 403
        end
      end

      def bucket_list_params
        params.permit(:name)
      end
    end
  end
end
