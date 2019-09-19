class ArticulatedsController < ApplicationController
  helper_method :amendment, :articulated

  # GET /amendments/:amendment_id/articulateds
  def index
  end

  # GET /amendments/:amendment_id/articulateds/new
  def new
    @articulated = amendment.build_articulated
  end

  # GET /amendments/:amendment_id/articulateds/:id/edit
  def edit
  end

  # POST /amendments/:amendment_id/articulateds
  def create
    @articulated = amendment.create_articulated(articulated_params)

    if articulated.save
      redirect_to amendment_path(amendment), notice: 'Articulated was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /amendments/:amendment_id/articulateds/1
  def update
    if articulated.update_attributes(articulated_params)
      redirect_to amendment_path(amendment), notice: 'Articulated was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /amendments/:amendment_id/articulateds/1
  def destroy
    articulated.destroy
    redirect_to amendment_path(amendment), notice: 'Articulated was successfully deleted.'
  end

    private

    def articulated_params
      params.require(:articulated).permit(:type, :section_id, :title, :text, :justification, :number, :number)
    end

    def articulated
      @articulated ||= amendment.articulated
    end

    def amendment
      @amendment ||= current_budget.amendments.find(params[:amendment_id])
    end
end
