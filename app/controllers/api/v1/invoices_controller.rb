class Api::V1::InvoicesController < ApplicationController
  before_action :set_bill_of_lading

  def generate
    result = Invoices::Generate.run(bill_of_lading: @bill_of_lading)

    if result.valid?
      json_response(
          data: {
            invoice: result.invoice,
            message: "Invoice generated successfully for ##{result.invoice.number}"
          },
          status: :created
      )
    else
        json_response(
          data: { errors: result.errors.full_messages },
          status: :unprocessable_entity
        )
    end
  end

  private

  def set_bill_of_lading
    @bill_of_lading = BillOfLading.find(params[:id])
  end
end
