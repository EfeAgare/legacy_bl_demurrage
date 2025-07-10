require 'rails_helper'

RSpec.describe RefundRequest, type: :model do
  describe 'associations' do
    it { should belong_to(:bill_of_lading) }
  end

  describe 'enums' do
   it do
      expect(described_class.statuses).to eq({
        "pending" => "pending",
        "rejected" => "rejected",
        "approved" => "approved",
        "processed" => "processed"
      })
    end
  end

  describe 'factories' do
    it 'has a valid factory' do
      expect(build(:refund_request)).to be_valid
    end
  end
end
