require 'rails_helper'

RSpec.describe 'User abilities' do
  context 'when is an anonymous guest' do
    it "can't do most things" do
      user = create :user
      ability = Ability.new(user)

      expect(ability).to_not be_able_to(:manage, Invitation.new)
      expect(ability).to_not be_able_to(:manage, User.new)
      expect(ability).to_not be_able_to(:manage, Group.new)
      expect(ability).to_not be_able_to(:manage, Role.new)
      expect(ability).to_not be_able_to(:manage, UserRole.new)
      expect(ability).to_not be_able_to(:manage, Affiliation.new)
    end
  end

  context 'when is an admin' do
    it 'can do everything' do
      user = create :user
      role = create :role, name: 'admin'
      user.roles << role
      ability = Ability.new(user)

      expect(ability).to be_able_to(:manage, :all)
    end
  end

  context 'when is a mentor' do
    it 'can see an all users' do
      user = create :user
      role = create :role, name: 'mentor'
      user.roles << role
      ability = Ability.new(user)

      expect(ability).to be_able_to(:read, User.new)
      expect(ability).to be_able_to(:update, User.new(user: user))
      expect(ability).to_not be_able_to(:delete, User.new)
    end
  end
end






  #
  # it 'checks all admin permissions' do
  #
  # end
  #
  # it 'checks all invited users permissions' do
  #
  # end
  #
  # it 'checks all enrolled users permissions' do
  #
  # end
  #
  # it 'checks all active student users permissions' do
  #
  # end
  #
  # it 'checks all exited users permissions' do
  #
  # end
  #
  # it 'checks all removed users permissions' do
  #
  # end
  #
  # it 'checks all mentor permissions' do
  #
  # end
# end
