FactoryGirl.define do
  factory :user do
    name 'John User'
    born_on 1.day.ago # i was not - yoda
    sequence(:email) {|n| "test#{n}@example.com" }
    sequence(:password) {|n| "really_secure_#{n}" }
    gender { [true, false].sample ? 'm' : 'f' }
  end

end
