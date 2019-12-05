# frozen_string_literal: true

class BudgetsController < ApplicationController
  helper_method :budget, :budgets

  def index; end

  private

  def budget
    @budget ||= Budget.find(params[:budget_id])
  end

  def budgets
    @budgets ||= Budget.order(date: :desc)
  end
end
