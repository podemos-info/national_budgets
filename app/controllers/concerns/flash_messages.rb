# frozen_string_literal: true

module FlashMessages
  extend ActiveSupport::Concern

  def flash_message(alert_type, icon_name, translation_params = {})
    fa_icon icon_name, text: t(".#{alert_type}", translation_params)
  end
end
