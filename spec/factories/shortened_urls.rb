FactoryBot.define do
  factory :shortened_url do
    target_url { "MyString" }
    short_path { "" }
    user_id { 1 }
  end
end
