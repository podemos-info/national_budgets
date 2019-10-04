# frozen_string_literal: true

class ArticulatedsController < ApplicationController
  include HasFlashMessages
  helper_method :budget, :amendment, :articulated

  # GET /amendments/:amendment_id/articulateds
  def index; end

  # GET /amendments/:amendment_id/articulateds/new
  def new
    @articulated = amendment.build_articulated
  end

  # GET /amendments/:amendment_id/articulateds/:id/edit
  def edit; end

  # POST /amendments/:amendment_id/articulateds
  def create
    @articulated = amendment.create_articulated(articulated_params)

    if articulated.save
      redirect_to amendment_path(amendment), success: flash_message(:success, :check)
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /amendments/:amendment_id/articulateds/1
  def update
    if articulated.update(articulated_params)
      redirect_to amendment_path(amendment), success: flash_message(:success, :check)
    else
      render action: 'edit'
    end
  end

  # DELETE /amendments/:amendment_id/articulateds/1
  def destroy
    articulated.destroy
    redirect_to amendment_path(amendment), success: flash_message(:success, :check)
  end

  private

  def articulated_params
    params.require(:articulated).permit(:type, :section_id, :title, :text, :justification, :number, :number)
  end

  def amendment
    @amendment ||= Amendment.find(params[:amendment_id])
  end

  def articulated
    @articulated ||= amendment&.articulated || Articulated.find(params[:id])
  end

  def budget
    @budget ||= amendment.budget
  end
end
