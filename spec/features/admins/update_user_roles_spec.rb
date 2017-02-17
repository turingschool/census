require 'rails_helper'

RSpec.describe 'Admin' do
  it 'can change a users role from student to graduated' do
    admin = create :admin
    sign_in admin

    student = create :user
    student_role = create :role, name: 'active student'
    graduated_role = create :role, name: 'graduated'
    student.roles << student_role
    visit user_path(student)

    click_on 'Graduate'
    expect(current_path).to eq user_path(student)
    expect(page).not_to have_content 'active student'
    expect(page).to have_content 'graduated'
  end

  it 'can change a users role from student to removed' do
    admin = create :admin
    sign_in admin

    student = create :user
    student_role = create :role, name: 'active student'
    graduated_role = create :role, name: 'removed'
    student.roles << student_role
    visit user_path(student)

    click_on 'Removed'
    expect(current_path).to eq user_path(student)
    expect(page).not_to have_content 'active student'
    expect(page).to have_content 'removed'
  end

  it 'can change a users role from student to exited' do
    admin = create :admin
    sign_in admin

    student = create :user
    student_role = create :role, name: 'active student'
    exited_role = create :role, name: 'exited'
    student.roles << student_role
    visit user_path(student)

    click_on 'Exited'
    expect(current_path).to eq user_path(student)
    expect(page).not_to have_content 'active student'
    expect(page).to have_content 'exited'
  end
end
