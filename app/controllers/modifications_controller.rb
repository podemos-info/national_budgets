class ModificationsController < ApplicationController
  before_action :set_modification, only: [:show, :edit, :update, :destroy]
  before_action :set_amendment

  # GET /amendments/:amendment_id/modifications
  # GET /amendments/:amendment_id/modifications.json
  def index
    @modifications = @modification.modification.all
  end

  # GET /amendments/:amendment_id/modifications/1
  # GET /amendments/:amendment_id/modifications/1.json
  def show
  end

  # GET /amendments/:amendment_id/modifications/new
  def new
    @modification = Modification.new
  end

  # GET /amendments/:amendment_id/modifications/1/edit
  def edit
  end

  # POST /amendments/:amendment_id/modifications
  # POST /amendments/:amendment_id/modifications.json
  def create
    @amendment = Amendment.find(params[:amendment_id])
    @modification = @amendment.modifications.new(modification_params)

    respond_to do |format|
      if @modification.save
        format.html { redirect_to amendment_path(@amendment), notice: 'Modification was successfully created.' }
        format.json { render action: 'show', status: :created, location: @modification }
      else
        format.html { render action: 'new' }
        format.json { render json: @modification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amendments/:amendment_id/modifications/1
  # PATCH/PUT /amendments/:amendment_id/modifications/1.json
  def update
    respond_to do |format|
      if @modification.update_attributes(modification_params)
        format.html { redirect_to amendment_path(@amendment), notice: 'Modification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @modification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amendments/:amendment_id/modifications/1
  # DELETE /amendments/:amendment_id/modifications/1.json
  def destroy
    @modification.destroy
    respond_to do |format|
      format.html { redirect_to amendment_path(@amendment) }
      format.json { head :no_content }
    end
  end

    private

    def set_modification
      @modification = Modification.find(params[:id])
    end

    def set_amendment
      @amendment = Amendment.find(params[:amendment_id])
    end

    def modification_params
      params.require(:modification).permit( :type, :section_id, :service_id, 
                                            :program_id, :chapter_id, 
                                            :article_id, :concept_id, 
                                            :subconcept_id, :project, 
                                            :project_new, :amount 
                                          )
    end
end
