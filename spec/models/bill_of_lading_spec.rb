require 'rails_helper'

RSpec.describe BillOfLading, type: :model do
  subject { create(:bill_of_lading) }

  describe 'associations' do
    it { should belong_to(:customer) }
    it { should have_many(:invoices).dependent(:destroy) }
    it { should have_many(:refund_requests).dependent(:destroy) }
  end

  describe 'validations' do
    subject { create(:bill_of_lading) }

    it { should validate_presence_of(:number) }
    it { should validate_uniqueness_of(:number).case_insensitive }
    it { should validate_presence_of(:arrival_date) }
    it { should validate_presence_of(:freetime) }
  end

  describe '#total_containers' do
    it 'returns the sum of all container counts' do
      bl = described_class.new(
        dry_20ft_count: 2,
        dry_40ft_count: 1,
        reefer_20ft_count: 1,
        reefer_40ft_count: 0,
        special_20ft_count: 3,
        special_40ft_count: nil
      )
      expect(bl.total_containers).to eq(7)
    end
  end

  describe '.overdue_today' do
    it 'returns BOLs whose arrival + freetime is today' do
      matching_bol = create(:bill_of_lading, arrival_date: Date.today - 7, freetime: 7)
      create(:bill_of_lading, arrival_date: Date.today - 10, freetime: 5)

      expect(BillOfLading.overdue_today).to include(matching_bol)
    end
  end
end
