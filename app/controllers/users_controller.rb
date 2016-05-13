class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :logged_in_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.users.per_page
  end

  def show
    show_data_user(@user) if user_signed_in?
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :avatar, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find params[:id]
  end
end
