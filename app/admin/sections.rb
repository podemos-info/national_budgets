# frozen_string_literal: true

ActiveAdmin.register Section do
  belongs_to :budget

  index do                                                      
    selectable_column                                           
    column :reference
    column :title do |section|                                   
      link_to(section.title, [:admin, section.budget, section])                   
    end                                                         
    actions defaults: true do |section|
      span link_to("Ver servicios", [:admin, section, :services])     
      span link_to("Ver organismos", [:admin, section, :organisms])     
    end                                                         
  end                                                           
end
