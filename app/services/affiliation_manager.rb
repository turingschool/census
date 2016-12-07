class AffiliationManager
  attr_reader :group_ids
  def initialize(group_ids)
    @group_ids = group_ids
  end

  def clean_groups
    group_ids.reject { |id| id == "" }
  end

  def checked_groups
    clean_groups.map { |id| Group.find(id) }
  end

  def unchecked_groups
    Group.all.reject { |group| checked_groups.include?(group) }
  end

  def create_affiliations_from_checked_groups
    checked_groups.each do |group|
      Affiliation.find_or_create_by(group: group, user: current_user)
    end
  end

  def unchecked_affiliations
    unchecked_groups.map do |group|
      Affiliation.find_by(group: group, user: current_user)
    end
  end

  def affiliations_to_destroy
    unchecked_affiliations.reject { |affiliation| affiliation == nil }
  end

  def destroy_affiliations_from_unchecked_groups

  end
end
