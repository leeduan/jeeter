require 'spec_helper'

describe PostType do
  it { should have_many(:posts) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
