Fabricator(:post_type) do
  name { Faker::Lorem.words(5).join(' ') }
end
