# frozen_string_literal: true

class ModificationsController < ApplicationController
  include ModelsHelper
  include HasFlashMessages
  helper_method :budget, :amendment, :modification, :modifications

  def index; end

  def new
    @modification = modifications.new(amount: amendment.balance.abs, type: amendment.next_modification_type)
  end

  def edit; end

  def create
    @modification = amendment.modifications.new(modification_params)

    if modification.save
      redirect_to after_create_path, success: flash_message(:success, :check)
    else
      render action: 'new'
    end
  end

  def update
    if modification.update(modification_params)
      redirect_to amendment_path(amendment), success: flash_message(:success, :check)
    else
      render action: 'edit'
    end
  end

  def destroy
    modification.destroy
    redirect_to amendment_path(amendment), danger: flash_message(:success, :trash)
  end

  private

  def after_create_path
    if amendment.completed?
      amendment_path(amendment)
    else
      new_amendment_modification_path(amendment)
    end
  end

  def modification_params
    @permited_params = %i[section_id service_id program_id organism_id
                          chapter_id article_id concept_id subconcept_id
                          project project_new amount]
    @permited_params << :type unless modification&.locked_type?

    params.require(:modification).permit(*@permited_params)
  end

  def modification
    @modification ||= (modifications.find(params[:id]) if params[:id])
  end

  def modifications
    @modifications ||= amendment.modifications
  end

  def amendment
    @amendment ||= Amendment.find(params[:amendment_id])
  end

  def budget
    @budget ||= amendment.budget
  end
end
