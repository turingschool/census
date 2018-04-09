require 'rails_helper'

RSpec.describe Cohort, type: :model do
  it "can update student roles" do
    cohort = Cohort.new(OpenStruct.new(id: 1234, status: "open"))
    user = create :active_student, cohort_id: cohort.id
    create :role, name: "active student"
    create :role, name: "graduated"

    cohort.update_student_roles("closed")
    expect(user.roles.first.name).to eq("graduated")
  end

  it "doesn't update students with wonky roles" do
    cohort = Cohort.new(OpenStruct.new(id: 1234, status: "open"))
    create :role, name: "active student"
    create :role, name: "graduated"
    create :role, name: "enrolled"
    exited = create :role, name: "exited"
    user = create :user, cohort_id: cohort.id
    user.roles << exited

    cohort.update_student_roles("open")
    expect(user.roles.first.name).to eq("exited")
  end
end
