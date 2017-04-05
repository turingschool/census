require 'rails_helper'

RSpec.describe 'Github find API' do
  context 'GET api/v1/users/by_github' do

    let(:user)  {create(:user, git_hub: 'username')}
    let(:token) {create(:access_token, resource_owner_id: user.id).token}

    context '_with_ authorization credentials' do
      context 'with one match to github username' do
        it 'returns match' do
          get '/api/v1/users/by_github?q=username', params: {access_token: token}

          expect(response).to be_success

          response_user = JSON.parse(response.body)

          expect(response_user).to be_a Hash
          expect(response_user['id']).to eq user.id
          expect(response_user['last_name']).to eq user.last_name
        end
      end
    
      context 'with multiple matches to github username' do
        it 'returns first match' do
          other_user = create(:user, git_hub: 'username')
          get '/api/v1/users/by_github?q=username', params: {access_token: token}

          expect(response).to be_success

          response_user = JSON.parse(response.body)

          expect(response_user).to be_a Hash
          expect(response_user['id']).to eq other_user.id
          expect(response_user['last_name']).to eq other_user.last_name
        end
      end

      context 'with no matches to github username' do
        it 'returns a 404 (not found) status' do
          get '/api/v1/users/by_github?q=name', params: {access_token: token}

          expect(response.status).to eq 404
        end
      end

      context 'with invalid parameters' do
        it 'returns a 404 (not found) status' do
          get '/api/v1/users/by_github?s=username', params: {access_token: token}

          expect(response.status).to eq 404
        end
      end
    end
  
    context '_without_ authorization credentials' do
      it 'returns a 401 (unauthorized) status' do
        get '/api/v1/users/by_github?q=username'

        expect(response.status).to eq 401
      end
    end
  end
end



