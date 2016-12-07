class AffiliationManager
  attr_reader :group_ids, :user
  def initialize(group_ids, user)
    @group_ids = group_ids
    @user = user
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
      Affiliation.find_or_create_by(group: group, user: user)
    end
  end

  def unchecked_affiliations
    unchecked_groups.map do |group|
      Affiliation.find_by(group: group, user: user)
    end
  end

  def destroy_affiliations_from_unchecked_groups
    unchecked_groups.each do |group|
      affiliation = Affiliation.find_by(group: group, user: user)
      affiliation.destroy if affiliation
    end
  end

  def run
    create_affiliations_from_checked_groups
    destroy_affiliations_from_unchecked_groups
  end
end
