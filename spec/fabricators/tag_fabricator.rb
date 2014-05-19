Fabricator(:tag) do
  name { Faker::Lorem.words(2).join(' ') }
end
