require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "email_problems" do
    mail = UserMailer.email_problems
    assert_equal "Email problems", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
