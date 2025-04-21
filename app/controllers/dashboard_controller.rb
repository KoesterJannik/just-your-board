class DashboardController < ApplicationController
  def index
    # Get all boards where user is owner or member using a single query
    @boards = Board.left_joins(:board_users)
                   .where("boards.user_id = :user_id OR board_users.user_id = :user_id", user_id: Current.user.id)
                   .distinct

    users_email = Current.user.email_address
    @open_invitations = Invitation.where(email: users_email)

    # Dashboard logic goes here
  end
end
