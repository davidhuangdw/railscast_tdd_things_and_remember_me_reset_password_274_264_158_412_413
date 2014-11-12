FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "davi#{n}@hi.com" }
    password '123'
    password_confirmation '123'
  end
end
