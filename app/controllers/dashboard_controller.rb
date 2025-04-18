class DashboardController < ApplicationController
  def index
    @boards = Current.user.boards
    puts "boards: #{@boards.inspect}"
    # Dashboard logic goes here
  end
end 