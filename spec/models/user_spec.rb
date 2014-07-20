require 'rails_helper'

describe User do
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:uploads) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:email) }
end
