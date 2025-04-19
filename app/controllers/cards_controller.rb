class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update destroy ]

  # GET /cards or /cards.json
  def index
    @cards = Card.all
  end

  # GET /cards/1 or /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new(column_id: params[:column_id])
  end

  # GET /cards/1/edit
  def edit
  end

  def update_positions
    request_body = JSON.parse(request.body.read)
    puts "Received parameters: #{request_body.inspect}"
    column = Column.find(request_body["column_id"])
    card_order = request_body["card_order"]
    puts "Card order: #{card_order.inspect}"
    counter  = 0

    for card in card_order
      puts "Card: #{card.inspect}"

      card_id = card["cardId"]
      card = Card.find(card_id)
      card.update(column: column)

    end

    for card in card_order
      puts "Card: #{card.inspect}"
      card_id = card["cardId"]
      card = Card.find(card_id)
      card.update(position: counter)
      puts "Card with name: #{card.name} updated to position: #{counter}"
      counter += 1
    end
    render json: { message: "Card positions updated" }
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
    respond_to do |format|
      if @card.update(card_params)
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
      params.require(:card).permit(:name, :description, :column_id, :priority)
    end
end
