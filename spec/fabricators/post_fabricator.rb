Fabricator(:post) do
  title { Faker::Lorem.words(10).join(' ') }
  content { "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>" }
  post_type
  user
  published_at Time.now
  publish_status true
end
