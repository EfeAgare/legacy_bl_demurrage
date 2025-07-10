class Customer < ApplicationRecord
  # Associations
  has_many :bill_of_ladings, dependent: :nullify

  # Validations
  validates :name, :group_name, :code, presence: true
  validates :code, uniqueness: true
end
