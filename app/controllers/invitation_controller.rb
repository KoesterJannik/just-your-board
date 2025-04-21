class InvitationController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  
  def create
    # The board_id will be in params[:board_id] because of nested routes
    board_id = params[:board_id]
    email = invitation_params[:email]
    
    user = User.find_by(email_address: email)
    if user
      # Check if the user is the owner of the board
      board = Board.find_by(id: board_id)
      if board.user_id == user.id
        redirect_to board_path(board_id), notice: "User is already the owner of this board"
        return
      end

      # Check if the user is already a member of the board
      if BoardUser.exists?(board_id: board_id, user_id: user.id)
        redirect_to board_path(board_id), notice: "User is already a member of this board"
        return
      end
    end

    # Check for existing invitations
    if Invitation.exists?(email: email, board_id: board_id)
      redirect_to board_path(board_id), notice: "User already has an invitation to this board"
      return
    end
    
    # Create and send the invitation
    Board.find(board_id).invitations.create(email: email)
    invitation_token = Board.find(board_id).invitations.last.token
    board = Board.find(board_id)
    InvitationMailer.invitation_email(email, board, invitation_token).deliver_now
    redirect_to board_path(board_id), notice: "Invitation sent to #{email}"
  end

  def accept
    # 1. find the invitation
    invitation = Invitation.find_by(token: params[:token], email: Current.user.email_address)
    puts "invitation: #{invitation}"
    # 2. find the board
    board = Board.find(invitation.board_id)
    puts "board: #{board}"
    # 3. add the user to the board
    BoardUser.create(board_id: board.id, user_id: Current.user.id)

    # delete the invitation
    invitation.destroy
    redirect_to board_path(board.id), notice: "Invitation accepted"
  end

  private

  def invitation_params
    # Remove board_id from required params since it comes from the URL
    params.require(:invitation).permit(:email)
  end


end
