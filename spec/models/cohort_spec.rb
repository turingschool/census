require 'rails_helper'

RSpec.describe Cohort, type: :model do
  it { should have_many(:users) }
  it { should validate_presence_of(:name) }

  it "knows how many students belong to it" do
    cohort = create :cohort, name: "1606-be"
    create :user, cohort: cohort
    create :user, cohort: cohort
    create :user, cohort: cohort
    create :user

    expect(cohort.student_count).to eq(3)
  end
end
