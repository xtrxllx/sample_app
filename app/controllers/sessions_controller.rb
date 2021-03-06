class SessionsController < ApplicationController
  def new;  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      params[:session][:remember_me] == Settings.remember_me ? remember(@user) : forget(@user)
      redirect_to user_path(id: current_user.id)
    else
      flash.now[:danger] = t ("login.fail")
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
