class UsersPresenter

  attr_reader :cohorts, :users, :selected
  def initialize(cohort_id = nil)
    @cohorts = Cohort.all
    if cohort_id != '' && cohort_id
      cohort = Cohort.find(cohort_id)
      @users = cohort.users
      @selected = cohort.name
    else
      @selected = 'All Users'
      @users = User.all
    end
  end


end
