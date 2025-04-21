class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update destroy ]

  # GET /cards or /cards.json
  def index
    @cards = Card.all
  end

  # GET /cards/1 or /cards/1.json
  def show
    puts "show card"
  end

  # GET /cards/new
  def new
    @card = Card.new(column_id: params[:column_id])
  end

  # GET /cards/1/edit
  def edit
  end

  def update_positions
    begin
      request_body = JSON.parse(request.body.read)

      # Validate required fields
      unless request_body.key?("column_id") && request_body.key?("card_order")
        return render json: { error: "Missing required fields: column_id and card_order" }, status: :unprocessable_entity
      end

      # Validate column exists
      user_id = Current.user.id
      column = Column.find_by(id: request_body["column_id"], user_id: user_id)
      unless column
        return render json: { error: "Column not found" }, status: :not_found
      end

      # Validate card_order is an array
      card_order = request_body["card_order"]
      unless card_order.is_a?(Array)
        return render json: { error: "card_order must be an array" }, status: :unprocessable_entity
      end

      # Validate each card exists
      card_order.each do |card_data|
        unless card_data.is_a?(Hash) && card_data.key?("cardId")
          return render json: { error: "Each card in card_order must have a cardId" }, status: :unprocessable_entity
        end

        card = Card.find_by(id: card_data["cardId"])
        unless card
          return render json: { error: "Card with id #{card_data["cardId"]} not found" }, status: :not_found
        end
      end

      # Update card columns
      card_order.each do |card_data|
        card = Card.find(card_data["cardId"])
        card.update(column: column)
      end

      # Update card positions
      card_order.each_with_index do |card_data, index|
        card = Card.find(card_data["cardId"])
        card.update(position: index)
      end

      render json: { message: "Card positions updated successfully" }
    rescue JSON::ParserError
      render json: { error: "Invalid JSON format" }, status: :bad_request
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params)
    # get length of cards in column
    @cards = Card.where(column_id: @card.column_id)
    @card.position = @cards.length

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card.column.board, notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    puts "Card Update Parameters: #{card_params.inspect}"
    puts "Previous assignee_id: #{@card.assignee_id.inspect}"
    
    respond_to do |format|
      if @card.update(card_params)
        puts "New assignee_id: #{@card.assignee_id.inspect}"
        puts "\e[42m\e[30m[NEW ASSIGNEE ID]\e[0m \e[32m#{@card.assignee_id}\e[0m"

        puts "Saved changes: #{@card.saved_changes.inspect}"
        format.html { redirect_to @card.column.board, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy!

    respond_to do |format|
      format.html { redirect_to @card.column.board, status: :see_other, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params.require(:id))
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:name, :description, :column_id, :priority, :assignee_id)
    end
end
