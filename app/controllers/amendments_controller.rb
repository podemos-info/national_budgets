# frozen_string_literal: true

class AmendmentsController < ApplicationController
  include ModelsHelper
  include HasFlashMessages
  include HasPseudoiframeBrowsing

  helper_method :budget, :amendment, :amendments, :section, :service, :program, :programs, :organism,
                :chapter, :article, :concept, :subconcept

  def index; end

  def show; end

  def new
    @amendment = amendments.new
  end

  def edit; end

  def create
    @amendment = current_user.amendments.new(amendment_params)
    amendment.budget = budget

    if amendment.save
      redirect_to after_create_path, success: flash_message(:success, :check)
    else
      render action: 'new'
    end
  end

  def update
    if amendment.update(amendment_params)
      redirect_to amendment_path(amendment), success: flash_message(:success, :check)
    else
      render action: 'edit'
    end
  end

  def destroy
    amendment.destroy
    redirect_to budget_amendments_path(budget), danger: flash_message(:success, :trash)
  end

  private

  def after_create_path
    if amendment.allow_articulated?
      new_amendment_articulated_path(amendment)
    else
      new_amendment_modification_path(amendment)
    end
  end

  def amendment_params
    @permited_params = %i[number explanation user_id]
    @permited_params << :type unless amendment&.locked_type?

    params.require(:amendment).permit(*@permited_params)
  end

  def budget
    @budget ||= amendment&.budget || Budget.find(params[:budget_id])
  end

  def amendment
    @amendment ||= params[:id] && Amendment.find(params[:id])
  end

  def amendments
    @amendments ||= budget.amendments
  end
end
