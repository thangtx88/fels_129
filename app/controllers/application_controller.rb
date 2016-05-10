class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include UsersHelper

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = t "views.login.notice"
      redirect_to new_session_path
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
end
