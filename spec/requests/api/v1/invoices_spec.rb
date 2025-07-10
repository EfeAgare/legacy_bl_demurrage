require 'rails_helper'

RSpec.describe "Api::V1::Invoices", type: :request do
  let(:customer) { create(:customer) }
  let(:bill_of_lading) { create(:bill_of_lading, customer: customer) }
  let(:headers) { { "Content-Type" => "application/json" } }

  describe "POST /api/v1/bill_of_ladings/:bill_of_lading_id/generate_invoice" do
    context "when invoice is generated successfully" do
      it "creates an invoice and returns 201" do
        post "/api/v1/bill_of_ladings/#{bill_of_lading.id}/generate_invoice", headers: headers

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["invoice"]["bill_of_lading_id"]).to eq(bill_of_lading.id)
        expect(json["message"]).to include("Invoice generated successfully")
      end
    end

    context "when an invoice already exists" do
      before do
        create(:invoice, bill_of_lading: bill_of_lading, status: "pending")
      end

      it "returns 422 with error message" do
        post "/api/v1/bill_of_ladings/#{bill_of_lading.id}/generate_invoice", headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Invoice already exists for this Bill of Lading")
      end
    end

    context "when total containers is zero" do
      let(:bill_of_lading) { create(:bill_of_lading,   dry_20ft_count: 0,
        dry_40ft_count: 0,
        reefer_20ft_count: 0,
        reefer_40ft_count: 0,
        special_20ft_count: 0,
        special_40ft_count: nil) }

      it "returns 422 with error about zero containers" do
        post "/api/v1/bill_of_ladings/#{bill_of_lading.id}/generate_invoice", headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Cannot generate invoice for zero containers")
      end
    end
  end
end
