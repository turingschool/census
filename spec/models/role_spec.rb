require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should have_many(:user_roles).dependent(:destroy) }
  it { should have_many(:users).through(:user_roles) }
end
