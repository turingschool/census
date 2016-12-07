require 'rails_helper'

RSpec.describe Affiliation, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:group) }
end
