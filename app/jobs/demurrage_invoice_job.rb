# This job is responsible for triggering the demurrage invoice generation process.
# Intended to be scheduled to run daily (e.g., via Sidekiq-scheduler, cron, or Heroku Scheduler).
#
# It calls Demurrage::InvoiceGenerator.run!, which:
# - Finds BLs that became overdue today
# - Skips those with existing open invoices
# - Creates one invoice per BL using Invoices::Generate interactor
class DemurrageInvoiceJob < ApplicationJob
  queue_as :default

  def perform
    Demurrage::InvoiceGenerator.run!
  end
end
