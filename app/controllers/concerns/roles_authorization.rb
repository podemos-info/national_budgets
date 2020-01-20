# frozen_string_literal: true

require 'active_support/concern'

module RolesAuthorization
  extend ActiveSupport::Concern

  included do
    before_action :admin_redirect, if: :admin?
  end

  private

  def admin_redirect
    return if current_user.super_admin?

    redirect_to budgets_path
  end

  def admin?
    is_a? ActiveAdmin::BaseController
  end
end
