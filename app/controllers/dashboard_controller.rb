class DashboardController < ApplicationController
  def index
    @boards = Current.user.boards

    # Dashboard logic goes here
  end
end 