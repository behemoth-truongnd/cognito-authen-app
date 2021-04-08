module Console
  class SessionsController < BaseController
    def destroy
      # Cognito.sign_out(session[:user_id])
      session.delete(:user_id)
      @cognito_user = nil
      redirect_to root_path
    end
  end
end
