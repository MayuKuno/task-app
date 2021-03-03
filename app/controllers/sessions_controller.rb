class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])
    if @user&.authenticate(session_params[:password])
      log_in(@user)
      redirect_to root_url, notice:'Logged in!'
    else
      flash[:alert] = 'Wrong password or username'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice:'Logged out!'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
