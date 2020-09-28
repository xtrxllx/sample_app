class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  def show; end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      flash[:danger] = "Wrong! please try again"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end
end
