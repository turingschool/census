class AffiliationsController < ApplicationController
  def new
    @affiliations = current_user.affiliations.new()
  end
end
