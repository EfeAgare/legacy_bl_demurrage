require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'associations' do
    it { should belong_to(:bill_of_lading) }
  end

  describe 'validations' do
    subject { create(:invoice) }

    it { should validate_presence_of(:reference) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:invoice_date) }

    it { should validate_uniqueness_of(:reference).case_insensitive }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe 'enums' do
   it do
      expect(described_class.statuses).to eq({
        "init" => "init",
        "pending" => "pending",
        "paid" => "paid",
        "cancelled" => "cancelled"
      })
    end
  end

  describe 'callbacks' do
    it 'generates a reference before create if not present' do
      invoice = build(:invoice, reference: nil)
      expect(invoice.reference).to be_nil

      invoice.save! # triggers before_create
      expect(invoice.reference).to be_present
    end
  end
end
