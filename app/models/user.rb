# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  has_many :amendments, dependent: :nullify
  has_many :amendments_documents, dependent: :nullify
  enum role: { 'super_admin' => 0, 'admin' => 1, 'editor' => 2 }
end
