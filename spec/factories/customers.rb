FactoryBot.define do
  factory :customer do
    name { Faker::Company.name }
    code { Faker::Alphanumeric.alphanumeric(number: 6).upcase }
    group_name { Faker::Company.industry }
    pays_deposit { [ true, false ].sample }
    reefer_freetime_days { rand(2..7) }
    dry_freetime_days { rand(5..10) }
    has_priority { [ true, false ].sample }
  end
end
