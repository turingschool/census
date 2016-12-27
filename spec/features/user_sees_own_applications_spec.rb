require 'rails_helper' 

RSpec.describe 'Oauth Applications' do
  it 'index shows a list of my applications' do
    me = create :user
    sign_in me
    my_application = create :oauth_application, owner: me
    
    visit oauth_applications_path

    expect(page).to have_content my_application.name
  end

  it 'are not visible to other users' do
    me = create :user
    sign_in me
    other = create :user
    app = create :oauth_application, owner: other

    visit oauth_applications_path

    expect(page).to_not have_content app.name
  end
end
