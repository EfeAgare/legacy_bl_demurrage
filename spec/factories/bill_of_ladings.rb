FactoryBot.define do
  factory :bill_of_lading do
    customer
    number { Faker::Alphanumeric.unique.alphanumeric(number: 9).upcase }
    consignee_code { customer.code }
    consignee_name { customer.name }
    arrival_date { rand(10..25).days.ago }
    freetime { rand(5..10) }
    dry_20ft_count { rand(0..4) }
    dry_40ft_count { rand(0..4) }
    reefer_20ft_count { rand(0..2) }
    reefer_40ft_count { rand(0..2) }
    special_20ft_count { rand(0..1) }
    special_40ft_count { rand(0..1) }
    status { "pending" }
  end
end
