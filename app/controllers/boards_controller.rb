class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update destroy ]
  before_action :current_user_only, only: %i[ show edit update destroy ]
  # GET /boards or /boards.json
  def index
    @boards = Board.where(user: Current.user)
  end

  # GET /boards/1 or /boards/1.json
  def show
    puts "MUHAHA"
    @all_users = User.all
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @board = Board.new(board_params)
    # add the current user to the board
    @board.user = Current.user



    respond_to do |format|
      if @board.save
        # add three defaults columns: todo, in progress, done
        @board.columns.create(name: "To Do")
        # create dummy cards for the board
        @board.columns.first.cards.create(name: "Card 1", description: "Description 1", priority: "low")
        @board.columns.first.cards.create(name: "Card 2", description: "Description 2", priority: "medium")
        @board.columns.first.cards.create(name: "Card 3", description: "Description 3", priority: "high")
        @board.columns.create(name: "In Progress")
        @board.columns.create(name: "Done")
        format.html { redirect_to @board, notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: "Board was successfully updated." }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    @board.destroy!

    respond_to do |format|
      format.html { redirect_to dashboard_path, status: :see_other, notice: "Board was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.expect(board: [ :title, :description, :user_id ])
    end
    # filter so the user can only see their own boards and edit them
    def current_user_only
      @board = Board.find(params.expect(:id))
      if @board.user != Current.user
        redirect_to boards_path, alert: "You are not authorized to access this board"
      end
    end
end
