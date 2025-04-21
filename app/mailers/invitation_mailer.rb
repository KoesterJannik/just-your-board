class InvitationMailer < ApplicationMailer
  def invitation_email(email, board, invitation_token)
    @board = board
    @invitation_token = invitation_token
    mail(to: email, subject: "Invitation to join #{board.title}")
  end
end
