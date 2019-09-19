class ModificationsController < ApplicationController
  attr_reader :section_id, :service_id, :program_id, 
              :chapter_id, :article_id, :concept_id, :subconcept_id
  helper_method :amendment, :modification, :modifications,
                :section, :service, :program,
                :chapter, :article, :concept, :subconcept

  # GET /amendments/:amendment_id/modifications
  def index
  end

  # GET /amendments/:amendment_id/modifications/new
  def new
    @modification = amendment.modifications.new
  end

  # GET /amendments/:amendment_id/modifications/:id/edit
  def edit
  end

  # POST /amendments/:amendment_id/modifications
  def create
    @modification = amendment.modifications.new(modification_params)

    if modification.save
      redirect_to amendment_path(amendment), notice: 'Modification was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /amendments/:amendment_id/modifications/:id
  def update
    if modification.update_attributes(modification_params)
      redirect_to amendment_path(amendment), notice: 'Modification was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /amendments/:amendment_id/modifications/:id
  def destroy
    modification.destroy
    redirect_to amendment_path(amendment)
  end

    private
    
    def modification_params
      params.require(:modification).permit( :type, :section_id, :service_id, 
                                            :program_id, :chapter_id, 
                                            :article_id, :concept_id, 
                                            :subconcept_id, :project, 
                                            :project_new, :amount 
                                          )
    end

    def modification
      @modification ||= amendment.modifications.find(params[:id])
    end

    def modifications
       @modifications ||= amendment.modifications
    end

    def amendment
      @amendment ||= current_budget.amendments.find(params[:amendment_id])
    end
end
