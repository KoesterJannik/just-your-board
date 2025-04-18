class ColumnsController < ApplicationController
  before_action :set_column, only: %i[ show edit update destroy ]

  # GET /columns or /columns.json
  def index
    @columns = Column.all
  end

  # GET /columns/1 or /columns/1.json
  def show
  end

  # GET /columns/new
  def new
    @column = Column.new(board_id: params[:board_id])
  end

  # GET /columns/1/edit
  def edit
  end

  # POST /columns or /columns.json
  def create
    # get the board id from the url
    ## print the whole payload
    puts "Payload: #{params.inspect}"
    @column = Column.new(column_params)

    respond_to do |format|
      if @column.save
        # redirect to the board show page
        format.html { redirect_to @column.board, notice: "Column was successfully created." }
        format.json { render :show, status: :created, location: @column }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /columns/1 or /columns/1.json
  def update
    respond_to do |format|
      if @column.update(column_params)
        format.html { redirect_to @column.board, notice: "Column was successfully updated." }
        format.json { render :show, status: :ok, location: @column }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @column.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /columns/1 or /columns/1.json
  def destroy
    @column.destroy!

    respond_to do |format|
      format.html { redirect_to @column.board, status: :see_other, notice: "Column was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = Column.find(params.require(:id))
    end

    # Only allow a list of trusted parameters through.
    def column_params
      params.require(:column).permit(:name, :board_id)
    end
end
