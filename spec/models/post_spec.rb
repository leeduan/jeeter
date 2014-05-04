require 'spec_helper'

describe Post do
  it { should belong_to(:post_type) }
  it { should have_many(:categories).through(:post_categories) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:post_type_id) }
  it { should validate_uniqueness_of(:title) }
end
