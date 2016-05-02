module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate, only: [:update, :destroy]
      skip_before_action :verify_authenticity_token
      respond_to :json

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: 201
        else
          render json: { errors: @user.errors }, status: 422
        end
      end

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
