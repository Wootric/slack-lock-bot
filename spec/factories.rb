require 'securerandom'

FactoryBot.define do
  sequence(:name) { |n| "test_#{n}" }

  factory :lock do
    name
    user_id { SecureRandom.hex(4) }
  end

  factory :stat do
    name
    user_id { SecureRandom.hex(4) }
    command { %w(list lock unlock).sample }
  end
end
