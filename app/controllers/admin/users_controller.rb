class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_user, except: [:index, :new, :create]
  before_action :valid_user, only: [:destroy]

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "views.update.success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "views.update.error"
      render :edit
    end
  end

  def destroy
    if @user.destroyed
      flash[:success] = t "admin.flash.deleted_success"
    else
      flash[:danger] = t "admin.flash.deleted_fails"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :avatar,
      :admin, :password, :password_confirmation
  end

  def find_user
    @user = User.find params[:id]
  end

  def valid_user
    if @user == current_user
      flash[:warning] = t "admin.flash.user_cannot"
      redirect_to admin_users_path
    end
  end
end
