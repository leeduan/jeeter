# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

blog_type = PostType.create(name: 'Blog')
admin_user = User.create(
  full_name: 'admin',
  username:  'admin',
  password:  'admin',
  email:     'noreply@jeeter.com'
  admin:     true
)
welcome_post = Post.create(
  title:          'Welcome to Jeeter',
  content:        '<p>Hello! This is your first blog post. Edit or delete it, then start blogging!</p>',
  post_type:      blog_type,
  user:           admin_user,
  published_at:   Time.now,
  publish_status: true
)
Comment.create(
  content:        'You can add a comment on each blog post.',
  post:           welcome_post,
  user:           admin_user,
  author_name:    admin_user.full_name,
  author_email:   admin_user.email
)