class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from JWT::ExpiredSignature, with: :expired_token

  def current_user
    @current_user ||= User.find_by(id: token['user_id'], online: true)
  end

  private

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

  def expired_token(e)
    render json: { error: e.message }, status: :unauthorized
  end

  def not_found(e)
    render json: { error: e.message }, status: :not_found
  end

  def paginate(obj)
    @limit = Paginator.limit(params[:limit])
    @offset = @limit * Paginator.page(params[:page])
    {
      total: obj.count, 
      page: Paginator.total_pages(obj.count),
      bucket_lists: obj.limit(@limit).offset(@offset) 
    }
  end
end
