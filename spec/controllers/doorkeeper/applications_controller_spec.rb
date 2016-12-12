require 'rails_helper'

RSpec.describe Doorkeeper::ApplicationsController, type: :controller do
  context "Visitor navigates to" do
    it "applications#index, they receive 404 page" do
      post :index

      expect(response.status).to eq(404)
    end

    it "applications#create, they receive 404 page" do
      post :create

      expect(response.status).to eq(404)
    end

    it "applications#new, they receive 404 page" do
      post :new

      expect(response.status).to eq(404)
    end

    it "applications#edit, they receive 404 page" do
      post :edit

      expect(response.status).to eq(404)
    end

    it "applications#show, they receive 404 page" do
      post :show

      expect(response.status).to eq(404)
    end

    it "applications#update, they receive 404 page" do
      post :update

      expect(response.status).to eq(404)
    end

    it "applications#destory, they receive 404 page" do
      post :destroy

      expect(response.status).to eq(404)
    end
  end
end
