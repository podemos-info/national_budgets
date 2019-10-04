# frozen_string_literal: true

module HasFlashMessages
  extend ActiveSupport::Concern

  def flash_message(alert_type, icon_name)
    fa_icon icon_name, text: t(".#{alert_type.to_s}")
  end
end
