require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'associations' do
    it { should have_many(:bill_of_ladings).dependent(:nullify) }
  end

  describe 'validations' do
    subject { create(:customer) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:group_name) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code).case_insensitive }
  end
end
