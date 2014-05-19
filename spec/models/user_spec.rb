require 'spec_helper'

describe User do
  it { should have_many(:posts) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
end
