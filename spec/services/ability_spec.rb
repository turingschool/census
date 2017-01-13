require 'rails_helper'

RSpec.describe 'User abilities:' do
  context 'invited user' do
    it 'cannot do anything until enrolled' do
      user = create :user
      role = create :role, name: 'invited'
      user.roles << role
      ability = Ability.new(user)

      expect(ability.cannot? :manage, :all).to eq(true)
    end
  end

  context 'enrolled or active student user' do
    it 'can manage most functionality' do
      user = create :user
      random_role = ['enrolled', 'active student'].shuffle.pop
      role = create :role, name: "#{random_role}"
      user.roles << role
      ability = Ability.new(user)

      expect(ability.can? :read, User).to eq(true)
      expect(ability.can? :update, User, user_id: user.id).to eq(true)
      expect(ability.can? :create, User).to eq(true)
      expect(ability.can? :read, Group).to eq(true)
      expect(ability.can? :read, Role).to eq(true)
      expect(ability.can? :read, Affiliation).to eq(true)
      expect(ability.can? :create, Affiliation).to eq(true)
      expect(ability.can? :update, Affiliation).to eq(true)
      expect(ability.can? :manage, Doorkeeper::Application, user_id: user.id).to eq(true)

      expect(ability.can? :delete, User).to eq(false)
      expect(ability.can? :manage, Invitation).to eq(false)
      expect(ability.can? :create, Group).to eq(false)
      expect(ability.can? :delete, Group).to eq(false)
      expect(ability.can? :manage, Role).to eq(false)
      expect(ability.can? :manage, UserRole).to eq(false)
      expect(ability.can? :delete, Affiliation).to eq(false)
    end
  end

  context 'anonymous guest' do
    it "can't do most things" do
      user = create :user
      ability = Ability.new(user)

      expect(ability.can? :manage, :all).to eq(false)
    end
  end

  context 'admin' do
    it 'can do everything' do
      user = create :user
      role = create :role, name: 'admin'
      user.roles << role
      ability = Ability.new(user)

      expect(ability.can? :manage, :all).to eq(true)
    end
  end

  context 'mentor' do
    it 'can see an all users' do
      user = create :user
      role = create :role, name: 'mentor'
      user.roles << role
      ability = Ability.new(user)

      expect(ability.can? :read, User, user_id: user.id).to eq(true)
      expect(ability.can? :update, User, user_id: user.id).to eq(true)
      expect(ability.can? :create, User).to eq(true)
      expect(ability.can? :read, Group).to eq(true)
      expect(ability.can? :read, Role).to eq(true)
      expect(ability.can? :read, Affiliation).to eq(true)
      expect(ability.can? :create, Affiliation).to eq(true)
      expect(ability.can? :update, Affiliation).to eq(true)
      expect(ability.can? :manage, Doorkeeper::Application, user_id: user.id).to eq(true)

      expect(ability.can? :delete, User).to eq(false)
      expect(ability.can? :manage, Invitation).to eq(false)
      expect(ability.can? :create, Group).to eq(false)
      expect(ability.can? :delete, Group).to eq(false)
      expect(ability.can? :manage, Role).to eq(false)
      expect(ability.can? :manage, UserRole).to eq(false)
      expect(ability.can? :delete, Affiliation).to eq(false)
    end
  end

  context 'exited or removed user' do
    it 'cannot do anything' do
      user = create :user
      random_role = ['exited', 'removed'].shuffle.pop
      role = create :role, name: "#{random_role}"
      user.roles << role
      ability = Ability.new(user)

      expect(ability.can? :manage, :all).to eq(false)
    end
  end
end
