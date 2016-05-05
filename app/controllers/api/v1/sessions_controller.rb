module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_filter :verify_signed_out_user
      before_action :set_params, only: :create

      respond_to :json

      def new
        super
      end

      # POST /auth/login
      def create
        user = @email.present? && User.find_by(email: @email)
        if user.nil? || !user.valid_password?(@password)
          render json: { errors: 'invalid user name or password' }, status: 422
          return false
        end

        user.valid_password? @password
        sign_in user, store: false
        user.update(online: true)
        token = AuthToken.issue(user_id: user.id)
        render json: { user_email: user.email, token: token }, status: 200
      end

      # DELETE /auth/logout
      def destroy
        current_user.update(online: false)
        render json: { message: 'signed out successfully' }, status: 410
      end

      private

      def set_params
        @email = params[:email]
        @password = params[:password]
      end
    end
  end
end
