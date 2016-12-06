require 'rails_helper'

RSpec.feature 'Filter users by cohort' do
  scenario 'by selecting cohort from dropdown' do
    user = create(:user)
    login(user)
  end
end
