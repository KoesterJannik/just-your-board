require "test_helper"

class CardMailerTest < ActionMailer::TestCase
  test "assignment_notification" do
    mail = CardMailer.assignment_notification
    assert_equal "Assignment notification", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
