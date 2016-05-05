class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: e.message }, status: :not_found
  end

  rescue_from JWT::ExpiredSignature do |e|
    render json: { error: e.message }, status: :unauthorized
  end

  private

  def current_user
    @current_user ||= User.find_by(id: token['user_id'], online: true)
  end

  def authenticate
    if token.key?(:error)
      render json: token, status: :unauthorized
      return false
    end

    if !token || current_user.nil?
      render json: { message: 'unauthorized access' }, status: :unauthorized
    end
  end

  def token
    AuthToken.decode(request.headers['token'])
  end
end
