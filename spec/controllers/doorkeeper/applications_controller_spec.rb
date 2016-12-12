require 'rails_helper'

RSpec.describe Doorkeeper::ApplicationsController, type: :controller do
  context "Visitor navigates to" do
    it "applications#new, the page is rendered successfully" do
      post :new

      expect(response.status).to eq(404)
    end

    it "applications#create, they are redirected" do
      post :create, doorkeeper_application: {name: "Monocle", redirect_uri: "https://localhost:3000/auth/census/callback", scopes: ""}

      expect(response.status).to eq(404)
    end

    it "applications#index, they receive 404 page" do
      post :index

      expect(response.status).to eq(404)
    end

    it "applications#edit, they receive 404 page" do
      get :edit, params: {id: 1}

      expect(response.status).to eq(404)
    end

    it "applications#show, they receive 404 page" do
      get :show, params: {id: 1}

      expect(response.status).to eq(404)
    end

    it "applications#update, they receive 404 page" do
      post :update, params: {id: 1, doorkeeper_application: {name: "Monocle"}}

      expect(response.status).to eq(404)
    end

    it "applications#destory, they receive 404 page" do
      delete :destroy, params: {id: 1}

      expect(response.status).to eq(404)
    end
  end
end
