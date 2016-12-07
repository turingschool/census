class AffiliationsController < ApplicationController
  def new
    @user = current_user
  end

  def create
    # binding.pry
    # checked_groups.each do |group|
    #   Affiliation.find_or_create_by(group: group, user: current_user)
    # end

    binding.pry
    create_affiliations_from_checked_groups
    destroy_affiliations_from_unchecked_groups
    redirect_to user_path(current_user)
  end

  private

    def clean_groups
      params[:user][:group_ids].reject { |id| id == "" }
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
