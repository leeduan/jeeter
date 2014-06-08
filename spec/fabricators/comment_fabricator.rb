Fabricator(:comment) do
  content { Faker::Lorem.paragraphs.join(' ') }
  post
  author_name { Faker::Name.name }
  author_email { Faker::Internet.email }
end
