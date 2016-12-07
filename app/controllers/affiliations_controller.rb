class AffiliationsController < ApplicationController
  def new
    redirect_to :edit if current_user.affiliations.count > 0
    @user = current_user
  end

  def create
    checked_groups.each do |group|
      Affiliation.find_or_create_by(group: group, user: current_user)
    end
    redirect_to user_path(current_user)
  end

  private

    def clean_groups
      params[:user][:group_ids].reject { |id| id == "" }
    end

    def checked_groups
      clean_groups.map { |id| Group.find(id) }
    end
end
