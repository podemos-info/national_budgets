# frozen_string_literal: true

class ArticulatedsController < ApplicationController
  include ModelsHelper
  include FlashMessages
  helper_method :budget, :amendment, :articulated

  def index; end

  def new
    @articulated = amendment.build_articulated
  end

  def edit; end

  def create
    @articulated = amendment.create_articulated(articulated_params)

    if articulated.save
      redirect_to amendment_path(amendment), success: flash_message(:success, :check)
    else
      render action: 'new'
    end
  end

  def update
    if articulated.update(articulated_params)
      redirect_to amendment_path(amendment), success: flash_message(:success, :check)
    else
      render action: 'edit'
    end
  end

  def destroy
    articulated.destroy
    redirect_to amendment_path(amendment), danger: flash_message(:success, :trash)
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
