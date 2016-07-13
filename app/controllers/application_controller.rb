class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: e.message }, status: :not_found
  end

  rescue_from JWT::ExpiredSignature do |e|
    render json: { error: e.message }, status: :unauthorized
  end

  def success
    Message::Success.new
  end

  def error
    Message::Error.new
  end

  private

  def current_user
    @current_user ||= User.find_by(id: token['user_id'], online: true)
  end

  def authenticate
    if token.key?(:error)
      render json: token, status: :unauthorized
      return
    end

    if !token || current_user.nil?
      render json: { message: error.denial }, status: :unauthorized
    end
  end

  def token
    AuthToken.decode(request.headers['token'])
  end
end
