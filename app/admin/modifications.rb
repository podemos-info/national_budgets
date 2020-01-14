# frozen_string_literal: true

ActiveAdmin.register Modification do
  belongs_to :amendment, optional: true
end
