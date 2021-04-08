class Cognito
  @client = Aws::CognitoIdentityProvider::Client.new(
    region: ENV['AWS_REGION'],
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  )

  def self.authenticate(params)
    auth_object = {
      user_pool_id: ENV['AWS_COGNITO_POOL_ID'],
      client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
      auth_flow: 'ADMIN_NO_SRP_AUTH',
      auth_parameters: {
        USERNAME: params[:email],
        PASSWORD: params[:password],
      }
    }

    @client.admin_initiate_auth(auth_object)
  end

  def self.confirm(username)
    @client.admin_confirm_sign_up({
      user_pool_id: ENV['AWS_COGNITO_POOL_ID'],
      username: username
    })
  end

  def self.sign_out(access_token)
    @client.global_sign_out(access_token: access_token)
  end

  def self.get_user_info(access_token)
    @client.get_user(access_token: access_token)
  end

  def self.create_user(params)
    password = params.delete(:password)
    auth_object = {
      client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
      username: params[:email],
      password: password,
      user_attributes: params.keys.map { |key| { name: key, value: params[key] } }
    }
    @client.sign_up(auth_object)
  end
end
