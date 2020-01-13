# frozen_string_literal: true

ActiveAdmin.register Program do
  menu false
  belongs_to :section, optional: true
  belongs_to :organism, optional: true

  index do
    column :ref, &:visible_ref
    column :title do |program|
      link_to(program.title, [:admin, program.parent, program])
    end
    column :section do |program|
      program.section ? link_to(program.section.full_title, [:admin, program.section]) : false
    end
    column :organism do |program|
      program.organism ? link_to(program.organism.full_title, [:admin, program.organism.section, program.organism]) : false
    end
  end

  show do
    attributes_table do
      row :ref, &:visible_ref
      row :title
      row :organism
      row :section
      row :budget
    end
  end
end
