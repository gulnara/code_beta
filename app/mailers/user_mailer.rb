class UserMailer < ActionMailer::Base
  default from: "gmirzaka@gmail.com"

  def email_problems(user, problem) 
    @user = user
    @problem = problem
    mail to: user.email, subject: "Solve a problem each day and land a job right away!"
  end
end
