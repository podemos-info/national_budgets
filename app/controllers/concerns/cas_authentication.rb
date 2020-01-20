# frozen_string_literal: true

require 'active_support/concern'
require 'rack-cas/server'

module CasAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  private

  def set_current_user
    return head(401) unless cas_user

    update_user!
    warden.set_user(current_user)
    request.env['rack.session.options'][:renew] = false
  end

  def current_user
    @current_user ||= User.find_or_initialize_by(user_name: cas_user)
  end

  def update_user!
    return unless user_update_needed?

    current_user.email = cas_info['extra_attributes']['mail']
    current_user.full_name = cas_info['extra_attributes']['cn']
    current_user.password = SecureRandom.base64(30)
    current_user.save!
    cookies[:user_updated] = true
  end

  def first_login?
    !cookies[:user_updated]
  end

  def user_update_needed?
    !current_user.persisted? || first_login?
  end

  def cas_info
    @cas_info ||= session['cas']
  end

  def cas_user
    @cas_user ||= cas_info && cas_info['user']
  end
end
