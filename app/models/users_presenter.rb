class UsersPresenter

  # attr_reader  :selected
  def initialize(cohort_id = nil)
    @cohort_id = cohort_id
    @all_selected = 'All Users'
    @all_users = User.all

    # if cohort_id != '' && cohort_id
    #   cohort = Cohort.find(cohort_id)
    #   # @users = cohort.users
    #   @selected = cohort.name
    # else
    #   @selected = 'All Users'
    #   # @users = User.all
    # end
  end

  def cohorts
    Cohort.all
  end

  def users
    if @cohort_id != '' && @cohort_id
      cohort = Cohort.find(@cohort_id)
      cohort.users
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
