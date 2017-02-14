require 'rails_helper'

RSpec.describe Oauth::ApplicationsController, type: :controller do
  context "Visitor navigates to" do
    it "oauth/applications#new, they receive 404 page" do
      post :new

      expect(response.status).to eq(404)
    end

    it "oauth/applications#create, they receive 404 page" do
      params = {oauth_application: {
        name: "Monocle",
        redirect_uri: "https://localhost:3000/auth/census/callback",
        scopes: ""}}
      post :create, params: params

      expect(response.status).to eq(404)
    end

    it "oauth/applications#index, they receive 404 page" do
      post :index

      expect(response.status).to eq(404)
    end

    it "oauth/applications#edit, they receive 404 page" do
      get :edit, params: {id: 1}

      expect(response.status).to eq(404)
    end

    it "oauth/applications#show, they receive 404 page" do
      get :show, params: {id: 1}

      expect(response.status).to eq(404)
    end

    it "oauth/applications#update, they receive 404 page" do
      post :update, params: {id: 1, doorkeeper_application: {name: "Monocle"}}

      expect(response.status).to eq(404)
    end

    it "oauth/applications#destory, they receive 404 page" do
      delete :destroy, params: {id: 1}

      expect(response.status).to eq(404)
    end
  end

  context "Logged in user navigates to" do
    before do
      @user = create :active_student
      sign_in @user
      @app = create :application, owner: @user
    end

    it "oauth/applications#new, the page is rendered successfully" do
      post :new

      expect(response.status).to eq(200)
    end

    it "oauth/applications#create, they are redirected" do
      params = {doorkeeper_application: {
        name: "Monocle",
        redirect_uri: "https://localhost:3000/auth/census/callback",
        scopes: ""}}
      post :create, params: params

      expect(response.status).to eq(302)
    end

    it "oauth/applications#index, the page is rendered successfully" do
      post :index

      expect(response.status).to eq(200)
    end

    it "oauth/applications#edit, the page is rendered successfully" do
      get :edit, params: {id: @app.id}

      expect(response.status).to eq(200)
    end

    it "oauth/applications#show, the page is rendered successfully" do
      get :show, params: {id: @app.id}

      expect(response.status).to eq(200)
    end

    it "oauth/applications#update, they are redirected" do
      post :update, params: {id: @app.id, doorkeeper_application: {name: "Monocle"}}

      expect(response.status).to eq(302)
    end

    it "oauth/applications#destory, they are redirected" do
      delete :destroy, params: {id: @app.id}

      expect(response.status).to eq(302)
    end
  end

  context "Admin navigates to" do
    before do
      @admin = create :admin
      sign_in @admin
      @app = create :application, owner: @admin
    end

    it "oauth/applications#new, the page is rendered successfully" do
      post :new

      expect(response.status).to eq(200)
    end

    it "oauth/applications#create, they are redirected" do
      params = {doorkeeper_application: {
        name: "Monocle",
        redirect_uri: "https://localhost:3000/auth/census/callback",
        scopes: ""}}
      post :create, params: params

      expect(response.status).to eq(302)
    end

    it "oauth/applications#index, the page is rendered successfully" do
      post :index

      expect(response.status).to eq(200)
    end

    it "oauth/applications#edit, the page is rendered successfully" do
      get :edit, params: {id: @app.id}

      expect(response.status).to eq(200)
    end

    it "oauth/applications#show, the page is rendered successfully" do
      get :show, params: {id: @app.id}

      expect(response.status).to eq(200)
    end

    it "oauth/applications#update, they are redirected" do
      post :update, params: {id: @app.id, doorkeeper_application: {name: "Monocle"}}

      expect(response.status).to eq(302)
    end

    it "oauth/applications#destory, they are redirected" do
      delete :destroy, params: {id: @app.id}

      expect(response.status).to eq(302)
    end
  end
end
