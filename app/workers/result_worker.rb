class ResultWorker
  include Sidekiq::Worker
   def send_email_when_user_complete_lesson user_id
     user = User.find_by id: user_id
     UserResultMailer.send_result(user)
   end
 end
