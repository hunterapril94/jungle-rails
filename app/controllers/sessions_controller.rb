class SessionsController < ApplicationController
  def new
  end

  def create
    # user = User.find_by_email(params[:email])
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # success logic, log them in
      session[:user_id] = user.id
      puts "user #{user.id} logged in"
      redirect_to '/'

    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
