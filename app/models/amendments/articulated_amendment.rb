# frozen_string_literal: true

module Amendments
  class ArticulatedAmendment < Amendment
    has_one :articulated, foreign_key: :amendment_id, dependent: :destroy, inverse_of: :amendment
    delegate :section, to: :articulated, allow_nil: true

    def any_articulated?
      articulated.present?
    end

    def allow_articulated?
      true
    end

    def completed?
      any_articulated?
    end

    def self.position
      3
    end

    def status_icon_params
      if completed?
        ['check-square-o', class: 'pl-2 text-success', title: I18n.t('helpers.action.completed')]
      else
        ['square-o', class: 'pl-2', title: I18n.t('helpers.action.incomplete_empty')]
      end
    end
  end
end
