Fabricator(:category) do
  name { Faker::Lorem.words(10).join(' ') }
  description { Faker::Lorem.sentence }
end
