Fabricator(:post) do
  title { Faker::Lorem.words(10).join(' ') }
  content { Faker::Lorem.paragraphs.join(' ') }
  post_type
  user
  published_at Time.now
  publish_status "Published"
end
