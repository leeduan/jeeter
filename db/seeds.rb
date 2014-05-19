# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PostType.create(name: 'Blog')
User.create(
  full_name: 'admin',
  username:  'admin',
  password:  'admin',
  admin:     true
)
Post.create(
  title:     'Welcome to Jeeter',
  content:   'Hello! This is your first blog post. Edit or delete it, then start blogging!',
  post_type: PostType.find_by(name: 'Blog'),
  user:      User.find_by(full_name: 'admin')
)
