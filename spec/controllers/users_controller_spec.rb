require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "Visitor navigates to" do
    it "user#index, they receive 404 page" do
      get :index

      expect(response.status).to eq(404)
    end

    it "user#show, they receive 404 page" do
      get :show, params: { id: 1 }

      expect(response.status).to eq(404)
    end

    it "user#edit, they receive 404 page" do
      get :edit, params: { id: 1 }

      expect(response.status).to eq(404)
    end

    it "user#update, they receive 404 page" do
      put :update, params: { id: 1 }

      expect(response.status).to eq(404)
    end
  end

  context "Logged in user navigates to" do
    before do
      @user = create :enrolled_user
      sign_in @user
    end

    it "user#index, page is served successfully" do
      get :index

      expect(response.status).to eq(200)
    end

    it "user#show, page is served successfully" do
      get :show, params: { id: @user.id }

      expect(response.status).to eq(200)
    end

    it "user#edit, page is served successfully" do
      get :edit, params: { id: @user.id }

      expect(response.status).to eq(200)
    end

    it "user#update, page is served successfully" do
      put :update, params: { id: @user.id, user: { first_name: "Ducky" }}

      expect(response.status).to eq(302)
    end
  end
end
