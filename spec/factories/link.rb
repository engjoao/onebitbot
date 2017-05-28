FactoryGirl.define do
  factory :link do
  	title FFaker::Lorem.phrase
    url FFaker::Internet.http_url
    company
  end
end
