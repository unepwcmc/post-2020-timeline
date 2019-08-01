class OrganisersController < ApplicationController
  before_action :set_organiser, only: [:show, :edit, :update, :destroy]

  # GET /organisers
  # GET /organisers.json
  def index
    @organisers = Organiser.all
  end

  # GET /organisers/1
  # GET /organisers/1.json
  def show
  end

  # GET /organisers/new
  def new
    @organiser = Organiser.new
  end

  # GET /organisers/1/edit
  def edit
  end

  # POST /organisers
  # POST /organisers.json
  def create
    @organiser = Organiser.new(organiser_params)

    respond_to do |format|
      if @organiser.save
        format.html { redirect_to @organiser, notice: 'Organiser was successfully created.' }
        format.json { render :show, status: :created, location: @organiser }
      else
        format.html { render :new }
        format.json { render json: @organiser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organisers/1
  # PATCH/PUT /organisers/1.json
  def update
    respond_to do |format|
      if @organiser.update(organiser_params)
        format.html { redirect_to @organiser, notice: 'Organiser was successfully updated.' }
        format.json { render :show, status: :ok, location: @organiser }
      else
        format.html { render :edit }
        format.json { render json: @organiser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organisers/1
  # DELETE /organisers/1.json
  def destroy
    @organiser.destroy
    respond_to do |format|
      format.html { redirect_to organisers_url, notice: 'Organiser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organiser
      @organiser = Organiser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organiser_params
      params.require(:organiser).permit(:name)
    end
end
