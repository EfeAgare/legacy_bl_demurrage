module Demurrage
  class InvoiceGenerator
    def self.run!
      # Service class for batch invoice generation.
      #
      # Intended to be called as a scheduled job (e.g., via Sidekiq, cron, or rake task).
      #
      # Logic:
      # - Finds all Bills of Lading that became overdue today
      # - Skips BLs that already have open/pending invoices
      # - Calculates amount based on container count and overdue days
      # - Uses Invoices::Generate Interactor for business logic
      #
      # Example usage:
      #   Demurrage::InvoiceGenerator.run!
      #
      # This can later be wired up to a background job or cron scheduler.
      BillOfLading.overdue_today.find_each do |bl|
        result = Invoices::Generate.run(bill_of_lading: bl)

        if result.valid?
          Rails.logger.info "Invoice generated for BL ##{bl.number}"
        else
          Rails.logger.warn "Skipped BL ##{bl.number}: #{result.errors.full_messages.to_sentence}"
        end
      end
    end
  end
end
