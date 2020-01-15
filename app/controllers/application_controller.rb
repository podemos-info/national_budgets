# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CasAuthentication
  include FontAwesome::Rails::IconHelper
  include ActionView::Helpers::TagHelper

  add_flash_types(:success, :info, :warning, :danger)
end
