FactoryBot.define do
  factory :invoice do
    bill_of_lading
    reference { SecureRandom.hex(5).upcase }
    number { bill_of_lading.number }
    customer_code { bill_of_lading.consignee_code }
    customer_name { bill_of_lading.consignee_name }
    amount { (bill_of_lading.total_containers * 80.0 * rand(1..3)).round(2) }
    original_amount { amount }
    currency { "USD" }
    status { %w[init pending paid cancelled].sample }
    invoice_date { Date.today }
    issued_at { Time.current }
    created_by_user_id { 1 }
    created_by_user_type { "admin" }
  end
end
