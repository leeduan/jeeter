Fabricator(:post) do
  title { Faker::Lorem.words(10).join(' ') }
  content { Faker::Lorem.paragraphs.join(' ') }
  post_type
  categories(count: 2)
  tags(count: 4)
end
