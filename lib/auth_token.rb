require 'jwt'

class AuthToken
  def self.issue(payload)
    payload[:exp] = 30.minutes.from_now.to_i 
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base, 
      true, {algorithm: 'HS256'})[0]
  rescue JWT::ExpiredSignature 
      { error: 'token expired' }
  rescue 
    false 
  end
end
