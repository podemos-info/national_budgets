# frozen_string_literal: true

module ActiveAdmin
  module BaseHelper
    def model_total(collection)
      "#{collection.length} #{model_name(collection, collection.length).downcase}"
    end

    def model_name(model, count = 2)
      model = model.to_s.camelcase.singularize.constantize if model.instance_of? Symbol
      model.model_name.human(count: count)
    end

    def model_name_with_total(collection)
      "#{model_name(collection.model_name.to_s.underscore.to_sym)} (#{collection.size})"
    end

    def collection_panel(context:, resource:, collection_model:)
      collection = resource.send(collection_model)
      context.panel link_to(model_name_with_total(collection), [:admin, resource, collection_model]) do
        collection.each do |object|
          context.li link_to(object.full_title, [:admin, resource, object])
        end
      end
    end
  end
end
