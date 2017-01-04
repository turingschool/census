require 'rails_helper'

RSpec.describe Doorkeeper::AuthorizationsController, type: :controller do
  context "Visitor navigates to" do
    it "doorkeeper/authorizations#new, they are redirected" do
      get :new

      expect(response.status).to eq(302)
    end
  end

  context "Logged in user navigates to" do
    before do
      @user = create :user
      sign_in @user
    end

    it "doorkeeper/authorizations#new, page is served successfully" do
      get :new

      expect(response.status).to eq(200)
    end
  end

  context "Admin navigates to" do
    before do
      @admin = create :admin
      sign_in @admin
    end

    it "doorkeeper/authorizations#new, page is served successfully" do
      get :new

      expect(response.status).to eq(200)
    end
  end
end
