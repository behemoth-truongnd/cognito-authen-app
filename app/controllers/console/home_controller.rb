module Console
  class HomeController < BaseController
    def index
      @email = @cognito_user.user_attributes.find{|a| a.name == "email"}.value
    end
  end
end
