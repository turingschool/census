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
end
