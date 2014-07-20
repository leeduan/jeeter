Fabricator(:tag) do
  name { Faker::Lorem.words(4).join(' ') }
end
