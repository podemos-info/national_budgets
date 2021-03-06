# frozen_string_literal: true

module Amendments
  class Articulated < Amendment
    has_one :articulated, foreign_key: :amendment_id, dependent: :destroy, inverse_of: :amendment, class_name: '::Articulated'
    delegate :section, to: :articulated, allow_nil: true

    def any_articulated?
      articulated.present?
    end

    def allow_articulated?
      true
    end

    def completed?
      any_articulated? && articulated.persisted?
    end

    def self.position
      3
    end

    def status_icon_params
      if completed?
        ['check-square-o', class: 'status text-success', title: I18n.t('helpers.action.completed')]
      else
        ['square-o', class: 'status', title: I18n.t('helpers.action.pending_articulated')]
      end
    end

    def numbered_articulateds
      self.class.numbered_articulateds
    end

    def self.numbered_articulateds
      ::Articulated.descendants.sort_by(&:position).map { |klass| klass if klass.articulated_number? }.compact
    end

    def number_pattern
      'A.S%02d.%1s'
    end
  end
end
