class BillOfLading < ApplicationRecord
  # Associations
  belongs_to :customer
  has_many :invoices, dependent: :destroy
  has_many :refund_requests, dependent: :destroy

  # Validations
  validates :number, presence: true, uniqueness: true
  validates :arrival_date, :freetime, presence: true

  # Returns the total number of containers for demurrage calculation
  def total_containers
    (dry_20ft_count || 0) + (dry_40ft_count || 0) + (reefer_20ft_count || 0) +
    (reefer_40ft_count || 0) + (special_20ft_count || 0) + (special_40ft_count || 0)
  end

  # Scope: Overdue today
  scope :overdue_today, -> {
    where("DATE(arrival_date + INTERVAL freetime DAY) = ?", Date.current)
  }

  # Calculate how many days it's overdue based on arrival_date and freetime
  def overdue_days
    due_date = arrival_date + freetime.days
    days = (Date.current - due_date.to_date).to_i
    days.positive? ? days : 0
  end
end
