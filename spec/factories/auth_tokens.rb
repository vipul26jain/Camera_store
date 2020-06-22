FactoryBot.define do
  factory :auth_token do
    expire_at { '2019-11-13' }
  end
end