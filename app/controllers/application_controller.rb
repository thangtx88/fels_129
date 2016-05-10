class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include UsersHelper

  private
  def logged_in_user
    unless user_signed_in?
      flash[:danger] = t "views.login.notice"
      redirect_to new_user_session_path
    end
  end

  def verify_admin
    unless current_user.admin?
      flash[:danger] = t "admin.flash.permission"
      redirect_to root_url
    end
  end

  def show_data_user user
    @categories = Category.all
    @words = Word.send("by_learned", user.id, @categories.map(&:id))
      .paginate page: params[:page]
    @count = @words.present? ? @words.count : 0
    @activities = user.activities.order(created_at: :DESC)
      .paginate page: params[:page], per_page: Settings.per_page
   end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |user|
        user.permit(:name, :avatar, :email,:password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |user|
      user.permit(:name, :avatar, :email,:password, :password_confirmation,
        :current_password)
    end
  end
end
