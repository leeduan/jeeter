module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search_by_column(search_term = '', page_str = '1', column_name = 'title')
      page_number = page_str.to_i
      page_number = page_number > 0 ? page_number : 1
      return self.page(page_number) if search_term.blank?
      where("#{column_name} LIKE ?", "%#{search_term}%").page(page_number)
    end
  end
end