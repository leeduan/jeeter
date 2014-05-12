Fabricator(:user) do
  username { Faker::Lorem.words(3).join('_') }
  password { Faker::Internet.password }
  full_name { Faker::Name.name }
end

Fabricator(:admin, from: :user) do
  admin true
end
