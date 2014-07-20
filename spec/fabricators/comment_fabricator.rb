Fabricator(:comment) do
  content { Faker::Lorem.paragraphs.join(' ') }
  post
  author_name { Faker::Lorem.words(10).join(' ') }
  author_email { Faker::Internet.email }
end
