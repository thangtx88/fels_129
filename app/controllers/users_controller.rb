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

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "views.signup.success"
      redirect_to @user
    else
      render "new"
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "views.update.success"
      redirect_to @user
    else
      flash[:danger] = t "views.update.error"
      render :edit
    end
  end

  def show
    show_data_user(@user) if logged_in?
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
