task :send_daily_mail => :environment do
    User.send_problem
end