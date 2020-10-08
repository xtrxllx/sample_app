class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def edit; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "forget.success"
      redirect_to root_path
    else
      flash.now[:danger] = t "forget.fail"
      render :new
    end
  end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t("forget.reset.error")
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update_attribute :reset_digest, nil
      flash[:success] = t "forget.reset.success"
      redirect_to @user
    else
      flash.now[:warning] = t "forget.reset.fail"
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by email: params[:email]
    return if @user.present?

    flash[:warning] = t "user.new.absent"
    redirect_to root_path
  end

  def valid_user
    return if @user && @user.authenticated?(:reset, params[:id])

    flash[:warning] = t "user.new.absent"
    redirect_to root_path
  end
end
