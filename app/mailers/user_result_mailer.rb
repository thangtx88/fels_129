class UserResultMailer < ApplicationMailer
  def send_result user_id
    @user = User.find_by id: user_id
    mail to: @user.email, subject: Setting.email_subject
  end
end
