# frozen_string_literal: true

namespace :national_budgets do
  desc 'Delete added objects without modification'
  task delete_added_objects_without_modification: :environment do
    [Program, Concept, Subconcept].each do |m|
      f = "#{m}_id".downcase.to_sym
      excluded_ids = Modification.distinct(f).pluck(f).compact
      m.where.not(id: excluded_ids,
                  added: false,
                  updated_at: 24.hours.ago..Time.current)
       .delete_all
    end
  end
end
