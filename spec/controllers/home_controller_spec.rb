require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context "Visitor navigates to" do
    it "home#index, they are redirected" do
      get :index

      expect(response.status).to eq(302)
    end
  end

  context "Logged in user navigates to" do
    it "home#index, the page is served successfully" do
      user = create :user
      sign_in user

      get :index

      expect(response.status).to eq(302)
    end
  end
end
