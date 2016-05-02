module Request
  module JsonHelpers
    def json_response
      JSON.parse(response.body, symbolize_names: true)
    end

    def token
      user = FactoryGirl.create(:user)
      credentials = { email: user.email, password: '1234567' }
      post :create, credentials
      json_response[:token]
    end
  end
end
