require 'rails_helper'

RSpec.describe 'Oauth Applications' do
  it 'index shows a list of my applications' do
    me = create :enrolled_user
    sign_in me
    my_application = create :application, owner: me

    visit oauth_applications_path

    expect(page).to have_content my_application.name
  end

  it 'are not visible to other users' do
    me = create :enrolled_user
    sign_in me
    other = create :user
    app = create :application, owner: other

    visit oauth_applications_path

    expect(page).to_not have_content app.name
  end
end
