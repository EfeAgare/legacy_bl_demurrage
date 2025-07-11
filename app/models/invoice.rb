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

  scope :overdue, -> {
    joins(:bill_of_lading)
      .where("DATE(bill_of_ladings.arrival_date + INTERVAL bill_of_ladings.freetime DAY) < ?", Date.current)
      .where.not(status: %w[paid cancelled])
  }

  private

  def generate_reference
    self.reference ||= SecureRandom.hex(5).upcase
  end
end
