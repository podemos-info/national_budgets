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
    return unauthorized unless cas_user
    return without_role unless role_from_directory

    update_user! if user_update_needed?
    warden.set_user(current_user)
    request.env['rack.session.options'][:renew] = false
  end

  def unauthorized
    cookies[:user_updated] = false
    head(401)
  end

  def without_role
    redirect_to RackCAS.config.server_url
  end

  def current_user
    @current_user ||= User.find_or_initialize_by(user_name: cas_user)
  end

  def update_user!
    current_user.assign_attributes(email: cas_info['extra_attributes']['mail'],
                                   full_name: cas_info['extra_attributes']['cn'],
                                   password: SecureRandom.base64(30),
                                   role: role_from_directory)
    current_user.save! && cookies[:user_updated] = true
  end

  def first_login?
    !ActiveModel::Type::Boolean.new.cast(cookies[:user_updated])
  end

  def user_update_needed?
    first_login? || !current_user.persisted?
  end

  def cas_info
    @cas_info ||= session['cas']
  end

  def cas_user
    @cas_user ||= cas_info && cas_info['user']
  end

  def directory_permissions
    @directory_permissions ||= DirectorioClient.get_data('permisos', cas_user).map(&:symbolize_keys).map do |p|
      p[:accion].to_sym if p[:objeto] == Rails.application.secrets.directorio[:object]
    end.compact
  end

  def role_from_directory
    return current_user.role if Rails.env.test? # HACK: Avoids to update user role from directory in test
    return :super_admin if directory_permissions.include?(:administrar)
    return :admin if directory_permissions.include?(:gestionar)
    return :editor if directory_permissions.include?(:editar)
  end
end
