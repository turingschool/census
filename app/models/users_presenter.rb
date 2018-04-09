class UsersPresenter

  def initialize(cohort_id = nil)
    @cohort_id = cohort_id
    @all_selected = 'All Users'
    @all_users = User.all.includes(:roles)
  end

  def cohorts
    @cohorts ||= Cohort.all
  end

  def cohort_name_for_user(user:)
    user_cohort = cohort(cohort_id: user.cohort_id)

    if user_cohort
      user_cohort.name
    else
      "n/a"
    end
  end

  def cohort(cohort_id:)
    cohorts.find { |cohort| cohort.id == cohort_id }
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
