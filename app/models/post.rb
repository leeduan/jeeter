class Post < ActiveRecord::Base
  default_scope { order('published_at DESC') }

  belongs_to :user
  belongs_to :post_type
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :post_type_id, presence: true

  def self.search_by_title(search_term = '', page_str = '1')
    page_number = page_str.to_i
    page_number = page_number > 0 ? page_number : 1
    return self.page(page_number) if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").page(page_number)
  end
end
