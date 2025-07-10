class RefundRequest < ApplicationRecord
  # Associations
  belongs_to :bill_of_lading

  enum status: {
    pending: "pending",
    rejected: "rejected",
    approved: "approved",
    processed: "processed"
  }
end
