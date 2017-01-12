# require 'rails_helper'
#
# RSpec.describe 'User abilities:' do
#   context 'invited user' do
#     it 'cannot do anything until enrolled' do
#       user = create :user
#       role = create :role, name: 'invited'
#       user.roles << role
#       ability = Ability.new(user)
#
#       expect(ability).to_not be_able_to(:manage, :all)
#     end
#   end
#
#   context 'enrolled or active student user' do
#     it 'can manage most functionality' do
#       user = create :user
#       random_role = ['enrolled', 'active student'].shuffle.pop
#       role = create :role, name: '#{random_role}'
#       user.roles << role
#       ability = Ability.new(user)
#
#       # expect(ability).to be_able_to(:read, User.new)
#       # expect(ability).to be_able_to(:update, User.new(user: user))
#       # expect(ability).to be_able_to(:create, User.new(user: user))
#       expect(ability).to be_able_to(:read, Group.new)
#       expect(ability).to be_able_to(:read, Role.new)
#       expect(ability).to be_able_to(:read, Affiliation.new)
#       expect(ability).to be_able_to(:manage, Doorkeeper::Application.new(user: user))
#
#       expect(ability).to_not be_able_to(:delete, User.new)
#       expect(ability).to_not be_able_to(:manage, Invitation.new)
#       expect(ability).to_not be_able_to(:create, Group.new)
#       expect(ability).to_not be_able_to(:delete, Group.new)
#       expect(ability).to_not be_able_to(:manage, Role.new)
#       expect(ability).to_not be_able_to(:manage, UserRole.new)
#       expect(ability).to_not be_able_to(:create, Affiliation.new)
#       expect(ability).to_not be_able_to(:update, Affiliation.new)
#       expect(ability).to_not be_able_to(:delete, Affiliation.new)
#     end
#   end
#
#   context 'anonymous guest' do
#     it "can't do most things" do
#       user = create :user
#       ability = Ability.new(user)
#       #
#       # expect(ability).to_not be_able_to(:manage, Invitation.new)
#       # expect(ability).to_not be_able_to(:manage, User.new)
#       # expect(ability).to_not be_able_to(:manage, Group.new)
#       # expect(ability).to_not be_able_to(:manage, Role.new)
#       # expect(ability).to_not be_able_to(:manage, UserRole.new)
#       # expect(ability).to_not be_able_to(:manage, Affiliation.new)
#       # expect(ability).to_not be_able_to(:manage, Doorkeeper::Application.new)
#       expect(ability).to_not be_able_to(:manage, :all)
#     end
#   end
#
#   context 'admin' do
#     it 'can do everything' do
#       user = create :user
#       role = create :role, name: 'admin'
#       user.roles << role
#       ability = Ability.new(user)
#
#       expect(ability).to be_able_to(:manage, :all)
#     end
#   end
#
#   context 'mentor' do
#     it 'can see an all users' do
#       user = create :user
#       role = create :role, name: 'mentor'
#       user.roles << role
#       ability = Ability.new(user)
#
#       expect(ability).to be_able_to(:read, User.new)
#       # expect(ability).to be_able_to(:update, User.new(user: user))
#       # expect(ability).to be_able_to(:create, User.new(user: user))
#       expect(ability).to be_able_to(:read, Group.new)
#       expect(ability).to be_able_to(:read, Role.new)
#       expect(ability).to be_able_to(:read, Affiliation.new)
#       # expect(ability).to be_able_to(:manage, Doorkeeper::Application.new(user: user))
#
#       expect(ability).to_not be_able_to(:delete, User.new)
#       expect(ability).to_not be_able_to(:manage, Invitation.new)
#       expect(ability).to_not be_able_to(:create, Group.new)
#       expect(ability).to_not be_able_to(:delete, Group.new)
#       expect(ability).to_not be_able_to(:manage, Role.new)
#       expect(ability).to_not be_able_to(:manage, UserRole.new)
#       expect(ability).to_not be_able_to(:create, Affiliation.new)
#       expect(ability).to_not be_able_to(:update, Affiliation.new)
#       expect(ability).to_not be_able_to(:delete, Affiliation.new)
#     end
#   end
#
#   context 'exited or removed user' do
#     it 'cannot do anything' do
#       user = create :user
#       random_role = ['exited', 'removed'].shuffle.pop
#       role = create :role, name: '#{random_role}'
#       user.roles << role
#       ability = Ability.new(user)
#
#       expect(ability).to_not be_able_to(:manage, :all)
#     end
#   end
# end
