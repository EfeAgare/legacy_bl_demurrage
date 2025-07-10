class InvoiceGenerator
  FLAT_RATE_PER_CONTAINER_PER_DAY = 80
  CURRENCY = "USD"

  def self.run!
    BillOfLading.overdue_today.find_each do |bl|
      next if bl.invoices.where(status: %w[open]).exists?
      containers = bl.total_containers
      next if containers.zero?
      amount = containers * FLAT_RATE_PER_CONTAINER_PER_DAY
      Invoice.create!(
        bill_of_lading: bl,
        customer: bl.customer,
        amount: amount,
        original_amount: amount,
        currency: CURRENCY,
        status: "pending",
        invoiced_at: Time.current,
        created_at: Time.current
      )
    end
  end
end
