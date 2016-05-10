module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_filter :verify_signed_out_user

      # POST /auth/login
      def create
        email = params[:email]
        password = params[:password]
        user = email.present? && User.find_by(email: email)
        if user.nil? || !user.valid_password?(password)
          render json: { errors: 'invalid user name or password' }, status: 422
          return
        end
        user.valid_password? password
        user.login
        token = AuthToken.issue(user_id: user.id)
        render json: { user_email: user.email, token: token }
      end

      # DELETE /auth/logout
      def destroy
        current_user.logout
        render json: { message: 'logout successfully' }
      end
    end
  end
end
