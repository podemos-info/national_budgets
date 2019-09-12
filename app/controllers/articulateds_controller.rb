class ArticulatedsController < ApplicationController
  before_action :set_articulated, only: [:show, :edit, :update, :destroy]
  before_action :set_amendment

  # GET /amendments/:amendment_id/articulateds
  # GET /amendments/:amendment_id/articulateds.json
  def index
    @articulateds = @amendment.articulated.all
  end

  # GET /amendments/:amendment_id/articulateds/1
  # GET /amendments/:amendment_id/articulateds/1.json
  def show
  end

  # GET /amendments/:amendment_id/articulateds/new
  def new
    @articulated = Articulated.new
  end

  # GET /amendments/:amendment_id/articulateds/1/edit
  def edit
  end

  # POST /amendments/:amendment_id/articulateds
  # POST /amendments/:amendment_id/articulateds.json
  def create
    #puts '€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€'
    @amendment = Amendment.find(params[:amendment_id])
    #puts @amendment.articulated
    #puts '********',@amendment
    @articulated = @amendment.articulateds.new(articulated_params)

    respond_to do |format|
      if @articulated.save
        format.html { redirect_to @articulated, notice: 'Articulated was successfully created.' }
        format.json { render action: 'show', status: :created, location: @articulated }
      else
        format.html { render action: 'new' }
        format.json { render json: @articulated.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amendments/:amendment_id/articulateds/1
  # PATCH/PUT /amendments/:amendment_id/articulateds/1.json
  def update
    respond_to do |format|
      if @articulated.update(articulated_params)
        format.html { redirect_to @articulated, notice: 'Articulated was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @articulated.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amendments/:amendment_id/articulateds/1
  # DELETE /amendments/:amendment_id/articulateds/1.json
  def destroy
    @articulated.destroy
    respond_to do |format|
      format.html { redirect_to articulateds_url }
      format.json { head :no_content }
    end
  end

    private

    def set_articulated
      @articulated = Articulated.find(params[:id])
    end

    def set_amendment
      puts '-----',params[:amendment_id],'-----'
      @amendment = Amendment.find(params[:amendment_id])
    end

    def articulated_params
      params.require(:articulated).permit(:type, :section_id, :title, :text, :justification, :number, :number)
    end
end
