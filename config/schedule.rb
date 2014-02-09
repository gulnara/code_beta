
set :output, "#{path}/log/problems_sent.log"


every 1.day do
  runner "UserMailer.email_problems(@user).deliver", :environment => :development
end


