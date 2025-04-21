# Preview all emails at http://localhost:3000/rails/mailers/card_mailer
class CardMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/card_mailer/assignment_notification
  def assignment_notification
    CardMailer.assignment_notification
  end
end
