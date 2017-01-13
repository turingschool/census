require 'rails_helper'

RSpec.describe Cohort, type: :model do
  it { should have_many(:users) }
end
