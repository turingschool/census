require 'rails_helper'

RSpec.describe AffiliationManager do
  it "has group_ids" do
    group_ids = ["", "2"]
    manager = AffiliationManager.new(group_ids)

    expect(manager.group_ids).to eq(group_ids)
  end

  it "can remove blank group_ids" do
    group_ids = ["", "2"]
    manager = AffiliationManager.new(group_ids)

    expect(manager.clean_groups).to eq(["2"])
  end

  it "can finds groups from group_ids" do
    group = create(:group)
    group_ids = ["", group.id]
    manager = AffiliationManager.new(group_ids)

    expect(manager.checked_groups).to eq([group])
  end

  it "can find unchecked groups" do
    checked_group = create(:group)
    unchecked_group = create(:group)
    group_ids = ["", checked_group.id]
    manager = AffiliationManager.new(group_ids)

    expect(manager.unchecked_groups).to eq([unchecked_group])
  end
end
