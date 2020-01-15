# frozen_string_literal: true

require 'active_support/concern'
require 'rack-cas/server'

module CasAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  def set_current_user
    return head(401) unless cas_user

    return redirect_to(RackCAS::Server.new(Rails.application.secrets.cas_server).logout_url.to_s) unless current_user

    warden.set_user(current_user)
  end

  def current_user
    @current_user ||= begin
      @current_user = User.find_or_initialize_by(user_name: cas_user)
      @current_user.email = cas_info['extra_attributes']['mail']
      @current_user.full_name = cas_info['extra_attributes']['cn']
      @current_user.password = SecureRandom.base64(30)
      @current_user.save!
      @current_user
    end
  end

  private

  def cas_info
    @cas_info ||= session['cas']
  end

  def cas_user
    @cas_user ||= cas_info && cas_info['user']
  end
end
