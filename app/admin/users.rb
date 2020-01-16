# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :full_name
    column :email
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :full_name
      row :email
      row :role
      row :current_sign_in_at
      row :sign_in_count
      row :created_at
    end
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :full_name
      f.input :email
      f.input :role
      f.input :email
    end
    f.actions
  end
end
