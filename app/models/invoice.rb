class Invoice < ApplicationRecord
  # Associations
  belongs_to :bill_of_lading

  # Validations
  validates :reference, :amount, :currency, :invoice_date, presence: true
  validates :reference, uniqueness: true
  validates :amount, numericality: { greater_than: 0 }

  enum status: {
    pending: "pending",
    paid: "paid",
    cancelled: "cancelled",
    init: "init"
  }

  before_validation :generate_reference, on: :create

  private

  def generate_reference
    self.reference ||= SecureRandom.hex(5).upcase
  end
end
