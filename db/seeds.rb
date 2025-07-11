puts "🌱 Seeding..."

Invoice.delete_all
RefundRequest.delete_all
BillOfLading.delete_all
Customer.delete_all

# Seed Customers
puts "👥 Seeding Customers..."
customers = Array.new(10) do
  Customer.create!(
    name: Faker::Company.name,
    code: Faker::Alphanumeric.alphanumeric(number: 6).upcase,
    group_name: Faker::Company.industry,
    pays_deposit: [ true, false ].sample,
    reefer_freetime_days: rand(2..7),
    dry_freetime_days: rand(5..10),
    has_priority: [ true, false ].sample
  )
end

# Seed Bill of Ladings
puts "📦 Seeding Bill of Ladings..."
bill_of_ladings = Array.new(20) do
  customer = customers.sample

  freetime_days = rand(5..10)
  arrived_at = freetime_days.days.ago.beginning_of_day

  BillOfLading.create!(
    number: Faker::Alphanumeric.unique.alphanumeric(number: 9).upcase,
    customer_id: customer.id,
    consignee_code: customer.code,
    consignee_name: customer.name,
    arrival_date: arrived_at,
    freetime: freetime_days,
    dry_20ft_count: rand(0..4),
    dry_40ft_count: rand(0..4),
    reefer_20ft_count: rand(0..2),
    reefer_40ft_count: rand(0..2),
    special_20ft_count: rand(0..1),
    special_40ft_count: rand(0..1),
    status: 'ARRIVED'
  )
end

# Seed Invoices
puts "🧾 Seeding Invoices..."
bill_of_ladings.sample(10).each do |bl|
  total_containers = bl.total_containers

  next if total_containers.zero?

  amount = total_containers * 80.0 * rand(1..3)

  Invoice.create!(
    reference: SecureRandom.hex(5).upcase,
    number: bl.number,
    customer_code: bl.consignee_code,
    customer_name: bl.consignee_name,
    amount: amount.round(2),
    original_amount: amount.round(2),
    currency: "USD",
    status: %w[pending paid cancelled].sample,
    invoice_date: Date.today,
    issued_at: Time.now,
    created_by_user_id: 1,
    created_by_user_type: 'admin',
    bill_of_lading_id: bl.id
  )
end

# Seed Refund Requests
puts "💰 Seeding Refund Requests..."
bill_of_ladings.sample(10).each do |bl|
  RefundRequest.create!(
    number: bl.number,
    amount_requested: "#{rand(1000..3000)}",
    amount_approved: "#{rand(500..1500)}",
    deduction: "#{rand(50..300)}",
    status: %w[pending processed rejected].sample,
    forwarder_id: rand(1..100),
    forwarder_notified: [ true, false ].sample,
    bank_notified: [ true, false ].sample,
    requested_at: rand(1..5).days.ago,
    consignee_number: bl.consignee_code,
    refund_party_name: Faker::Company.name,
    beneficiary: Faker::Name.initials(number: 20),
    deposit_amount: "#{rand(500..2000)}",
    refund_reason: Faker::Lorem.sentence(word_count: 4),
    remarks: Faker::Lorem.sentence(word_count: 6),
    company_code: Faker::Alphanumeric.alphanumeric(number: 4).upcase,
    email: Faker::Internet.email,
    unpacking_type: [ 'Bulk', 'Container', 'Mixed' ].sample,
    client_approval: [ true, false ].sample,
    internal_comment: "Seeded by script",
    reference_number: SecureRandom.hex(4).upcase,
    bill_of_lading_id: bl.id
  )
end

puts "✅ Seeding complete."
puts "- #{Customer.count} customers"
puts "- #{BillOfLading.count} bills of lading"
puts "- #{Invoice.count} invoices"
puts "- #{RefundRequest.count} refund requests"
puts "Expected overdue count: #{BillOfLading.overdue_today.count}"
