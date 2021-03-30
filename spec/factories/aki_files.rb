FactoryBot.define do
  factory :aki_file do
    filename { Faker::File.file_name }
    contents { Faker::Lorem.paragraph }
    user_id nil
  end
end
