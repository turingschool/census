class Admin::CohortsController < ApplicationController
  before_action :set_cohort, only: [:show, :update, :destroy, :edit]

  def index
    @cohorts = Cohort.all
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.new(cohort_params)
    if @cohort.save
      redirect_to admin_cohorts_path
    else
      flash[:error] = @cohort.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @cohort.update_attributes(cohort_params)
      redirect_to admin_cohorts_path
    else
      flash[:error] = @cohort.errors.full_messages.join(', ')
      redirect_to admin_cohort_path(@cohort)
    end
  end

  def destroy
    @cohort.destroy

    flash[:notice] = "Cohort deleted!"
    redirect_to admin_cohorts_path
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name)
  end

  def set_cohort
    @cohort = Cohort.find(params[:id])
  end
end
