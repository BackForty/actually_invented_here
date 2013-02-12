class SessionsController < ApplicationController
  def create
    if user = subdomain.users.authenticate(params[:email], params[:password])
      session[:user_token] = user.generate_token
    end
  end
end
