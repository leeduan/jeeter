Fabricator(:category) do
  name { Faker::Lorem.words(3).join(' ') }
  description { Faker::Lorem.sentence }
end
