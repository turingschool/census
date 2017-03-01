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

  it "can update student roles" do
    cohort = create :cohort, name: "1608-BE"
    user = create :enrolled_user, cohort: cohort
    create :role, name: "active student"
    create :role, name: "graduated"

    cohort.update_student_roles("active")
    expect(user.roles.first.name).to eq("active student")
  end

  it "doesn't update students with wonky roles" do
    cohort = create :cohort, name: "1608-BE"
    create :role, name: "active student"
    create :role, name: "graduated"
    create :role, name: "enrolled"
    exited = create :role, name: "exited"
    user = create :user, cohort: cohort
    user.roles << exited

    cohort.update_student_roles("active")
    expect(user.roles.first.name).to eq("exited")
  end
end
