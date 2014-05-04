require 'spec_helper'

describe PostType do
  it { should have_many(:posts).order('created_at DESC') }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
