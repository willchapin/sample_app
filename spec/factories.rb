FactoryGirl.define do 
  factory :user do
    sequence(:name) {|n| "user-#{n}"}
    sequence(:email) {|n| "user-#{n}@example.com"}
    password              "foobar"
    password_confirmation "foobar"
  end
end
