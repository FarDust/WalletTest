# frozen_string_literal: false

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, '0')}@example.com" }
    password { '123456' }
  end

  factory :category do 
    name {'comida'}
    description {'categoria para los gastos de comida'}
  end

  factory :account do 
    user
    balance {3000}
    type {"credito"}
    currency {"US"}
    quota {"200"}
  end

  factory :natural_person do 
    nombre {"Jhon"}
    apelldio {"Doe"}
  end

  factory :debt do 
    amount {3000}
    for_user 

    trait :for_user do
      association :acreedor, factory: :user
      association :deudor, factory: :user
    end

    trait :for_natural_acreedor do 
      association :acreedor, factory: :natural_person
      association :deudor, factory: :user
    end

    trait :for_natural_deudor do 
      association :acreedor, factory: :user
      association :deudor, factory: :natural_person
    end
    
  end

  factory :movement do 
    category
    account
    final_balance {2322}
    amount {2323}
  end


end
