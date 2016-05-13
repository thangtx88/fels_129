class UserResultMailer < ApplicationMailer
  def send_result user_id
    @user = User.find_by id: user_id
    mail to: @user.email, subject: Setting.email_subject
  end

  def send_stactics user_id
    @user = User.find_by id: user_id
    @lesson = Lesson.find_by user_id: @user.id
    if @lesson != nil
      mail to: @user.email, subject: Setting.email_subject
    end
  end
end
