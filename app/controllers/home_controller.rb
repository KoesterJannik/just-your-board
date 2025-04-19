class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[index register create_account]
  def index
  end

  def register
    @user = User.new
  end

  def create_account
    puts "Creating account"
    puts "received params: #{params.inspect}"
    @user = User.new(user_params)
    # check if email is already taken
    if User.exists?(email_address: @user.email_address)
      redirect_to register_path, notice: "Email already taken"
    else
      if @user.save
        redirect_to root_path, notice: "Account created successfully"
      else
      # return the errors
        redirect_to register_path, notice: @user.errors.full_messages.join(", ")
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
