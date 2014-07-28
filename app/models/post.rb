class Post < ActiveRecord::Base
  default_scope { includes(:user, :categories, :comments).order('published_at DESC') }
  include Searchable

  belongs_to :user
  belongs_to :post_type
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :comments

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :post_type_id, presence: true

  scope :blog_posts_only, -> { where(publish_status: true)
    .includes(:post_type).where(post_types: { name: 'Blog' }) }

  def publish_status_name
    if publish_status?
      published_at <= Time.now ? 'Published' : 'Pending'
    else
      'Draft'
    end
  end
end
