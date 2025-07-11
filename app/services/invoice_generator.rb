class InvoiceGenerator
  def self.run!
    BillOfLading.overdue_today.find_each do |bl|
      result = Invoices::Generate.run(bill_of_lading: bl)
      if result.valid?
        Rails.logger.info "Invoice generated for BL ##{bl.number}"
      else
        Rails.logger.info "Skipped BL ##{bl.number}: #{result.errors.full_messages.to_sentence}"
      end
    end
  end
end
