namespace :result do
  desc "Send Email Last Day Of Month Report result for user"
  task :last_day_month_result => :environment do
    User.all.each do |user|
      UserResultMailer.send_stactics(user.id)
    end
  end
end
