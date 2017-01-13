class Admin::CohortsController < ApplicationController
  def index
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.new(cohort_params)
  end

  def show
    @cohort = Cohort.find(params[:id])
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    @cohort = Cohort.find(params[:id])
    if @cohort.update_attributes(cohort_params)
      redirect_to admin_cohorts_path
    else
      flash[:error] = @cohort.errors.full_messages.join(', ')
      redirect_to admin_cohort_path(@cohort)
    end
  end

  def destroy
    if Cohort.delete(params[:id])
      redirect_to admin_cohorts_path
    end
  end

  private

  def cohort_params
    byebug
  end
end
