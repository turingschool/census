class UsersPresenter

  def initialize(cohort_id = nil)
    @cohort_id = cohort_id
    @all_selected = 'All Users'
    @all_users = User.all.includes(:roles)
  end

  def cohorts
    Cohort.all
  end

  def users
    if @cohort_id != '' && @cohort_id
      cohort = Cohort.find(@cohort_id)
      cohort.users.includes(:roles)
    else
      @all_users
    end
  end

  def selected
    if @cohort_id != '' && @cohort_id
      cohort = Cohort.find(@cohort_id)
      cohort.name
    else
      @all_selected
    end
  end

end
