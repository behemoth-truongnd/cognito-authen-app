module Console
  class BaseController < ApplicationController
    before_action :auth_user

    private

    def auth_user
      if params[:access_token]
        session[:user_id] = params[:access_token]
      end
      @cognito_user = Cognito.get_user_info(session[:user_id])

      raise "You have to sign in!" if @cognito_user.blank?

    end
  end
end
