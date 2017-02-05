class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.all
    @group = Group.new
  end

end
