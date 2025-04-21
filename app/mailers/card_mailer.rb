class CardMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.card_mailer.assignment_notification.subject
  #
  def assignment_notification(card)
    @card = card
    @assignee = card.assignee
    @board = card.column.board

    mail(
      to: @assignee.email_address,
      subject: "You've been assigned to a card: #{@card.name}"
    )
  end
end
