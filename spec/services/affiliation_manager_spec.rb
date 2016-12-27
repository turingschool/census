require 'rails_helper'

RSpec.describe AffiliationManager do
  it "has group_ids and a user" do
    group_ids = ["", "2"]
    user = create(:user)
    manager = AffiliationManager.new(group_ids, user)

    expect(manager.group_ids).to eq(group_ids)
    expect(manager.user).to eq(user)
  end

  it "can remove blank group_ids" do
    group_ids = ["", "2"]
    manager = AffiliationManager.new(group_ids, nil)

    expect(manager.clean_groups).to eq(["2"])
  end

  it "can finds groups from group_ids" do
    group = create(:group)
    group_ids = ["", group.id]
    manager = AffiliationManager.new(group_ids, nil)

    expect(manager.checked_groups).to eq([group])
  end

  it "can find unchecked groups" do
    checked_group = create(:group)
    unchecked_group = create(:group)
    group_ids = ["", checked_group.id]
    manager = AffiliationManager.new(group_ids, nil)

    expect(manager.unchecked_groups).to eq([unchecked_group])
  end

  it "can create affiliations from checked groups" do
    user = create(:user)
    checked_group = create(:group)
    unchecked_group = create(:group)
    group_ids = ["", checked_group.id]
    manager = AffiliationManager.new(group_ids, user)

    manager.create_affiliations_from_checked_groups
    affiliations = user.affiliations

    expect(affiliations.count).to eq(1)
    expect(affiliations.first.group).to eq(checked_group)
  end

  it "can removes destroy unchecked affiliations" do
    group_1 = create(:group)
    group_2 = create(:group)
    group_3 = create(:group)
    user = create(:user)
    create(:affiliation, group: group_1, user: user)
    group_ids = ["", group_2.id, ""]

    manager = AffiliationManager.new(group_ids, user)

    manager.destroy_affiliations_from_unchecked_groups

    expect(user.affiliations.count).to eq(0)
  end

  it "will create checked affiliations and destroy unchecked affiliations" do
    group_1 = create(:group)
    group_2 = create(:group)
    group_3 = create(:group)
    user = create(:user)
    create(:affiliation, group: group_1, user: user)
    group_ids = ["", group_2.id, group_3.id]

    AffiliationManager.new(group_ids, user).run

    user.affiliations.each do |affiliation|
      expect([group_2, group_3]).to include(affiliation.group)
    end
  end
end
