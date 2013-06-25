FactoryGirl.define do 
  factory :user do
    sequence(:name) {|n| "user-#{n}"}
    sequence(:email) {|n| "user-#{n}@example.com"}
    password              "foobar"
    password_confirmation "foobar"
  
    factory :admin do
      admin true
    end
  end
end
