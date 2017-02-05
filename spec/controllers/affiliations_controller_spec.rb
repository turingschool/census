require 'rails_helper'

RSpec.describe AffiliationsController, type: :controller do
  context 'Visitor navigates to' do
    it 'affiliations#create, they receive 404 page' do
      post :create

      expect(response.status).to eq(404)
    end

    it 'affiliations#new, they receive 404 page' do
      get :new

      expect(response.status).to eq(404)
    end
  end

  context 'Logged in user navigates to' do
    before do
      @user = create :enrolled_user
      sign_in @user
    end
    it 'affiliations#create, they are redirected' do
      group = create :group
      post :create, params: { user: { group_ids: [group.id] } }

      expect(response.status).to eq(302)
    end

    it 'affiliations#new, they are given a form' do
      get :new

      expect(response.status).to eq(200)
    end
  end
end
