require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_many(:affiliations).dependent(:destroy) }
  it { should have_many(:users).through(:affiliations) }
end
