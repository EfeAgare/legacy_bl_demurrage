module Invoices
  class Generate < ActiveInteraction::Base
    object :bill_of_lading, class: BillOfLading

    attr_reader :invoice

    def execute
      if bill_of_lading.overdue_days.zero?
        errors.add(:base, "Bill of Lading is not yet overdue")
        return
      end

      if bill_of_lading.invoices.where(status: %w[pending init open]).exists?
        errors.add(:base, "Invoice already exists for this Bill of Lading")
        return
      end

      if bill_of_lading.total_containers.zero?
        errors.add(:base, "Cannot generate invoice for zero containers")
        return
      end

      amount = calculate_amount(bill_of_lading)

      @invoice = Invoice.create!(
        bill_of_lading: bill_of_lading,
        customer_code: bill_of_lading.consignee_code,
        customer_name: bill_of_lading.consignee_name,
        reference: SecureRandom.hex(5).upcase,
        amount: amount,
        original_amount: amount,
        currency: "USD",
        status: "pending",
        issued_at: Time.now,
        invoice_date: Time.current,
        number: bill_of_lading.number,
        created_by_user_id: 1,
        created_by_user_type: "admin",
      )
    rescue ActiveRecord::RecordInvalid => e
      errors.merge!(e.record.errors)
    end

    private

    def calculate_amount(bill)
      daily_rate = 80.00 # USD
      overdue_days = bill.overdue_days
      container_count = bill.total_containers
      overdue_days * container_count * daily_rate
    end
  end
end
