module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_filter :verify_signed_out_user

      respond_to :json

      def new
        super
      end

      # POST /auth/login
      def create
        user_email = params[:email]
        user_password = params[:password]
        user = user_email.present? && User.find_by(email: user_email)
        if user.valid_password? user_password
          sign_in user, store: false
          user.update(online: true)
          token = AuthToken.issue(user_id: user.id)
          render json: { user_email: user.email, token: token }, status: 200
        else
          render json: { errors: 'invalid user name or password' }, status: 422
        end
      end

      # DELETE /auth/logout
      def destroy
        current_user.update(online: false)
        render json: { message: 'signed out successfully' }, status: 410
      end
    end
  end
end
