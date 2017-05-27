FactoryGirl.define do
  factory :link do
    address FFaker::Internet.http_url
  end
end
