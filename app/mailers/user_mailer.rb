class UserMailer < ActionMailer::Base
  default from: "CodeBeta <codebeta3@gmail.com>"

  def email_problems(user, problem) 
    @user = user
    @problem = problem
    mail to: user.email, subject: "Solve a problem each day and land a job right away!"
  end
end
