FactoryBot.define do
  factory :refund_request do
    bill_of_lading

    number { bill_of_lading.number }
    amount_requested { rand(1000..3000).to_s }
    amount_approved { rand(500..1500).to_s }
    deduction { rand(50..300).to_s }
    status { %w[pending processed rejected].sample }
    forwarder_id { rand(1..100) }
    forwarder_notified { [ true, false ].sample }
    bank_notified { [ true, false ].sample }
    requested_at { rand(1..5).days.ago }
    consignee_number { bill_of_lading.consignee_code }
    refund_party_name { Faker::Company.name }
    beneficiary { Faker::Name.initials(number: 20) }
    deposit_amount { rand(500..2000).to_s }
    refund_reason { Faker::Lorem.sentence(word_count: 4) }
    remarks { Faker::Lorem.sentence(word_count: 6) }
    company_code { Faker::Alphanumeric.alphanumeric(number: 4).upcase }
    email { Faker::Internet.email }
    unpacking_type { %w[Bulk Container Mixed].sample }
    client_approval { [ true, false ].sample }
    internal_comment { "Seeded by factory" }
    reference_number { SecureRandom.hex(4).upcase }
  end
end
