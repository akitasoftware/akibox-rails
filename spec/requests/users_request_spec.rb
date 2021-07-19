require 'rails_helper'

RSpec.describe "Users", type: :request do
  # Initialize test data.
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }

  # Test suite for POST /users.
  describe 'POST /users' do
    # Valid payload.
    let(:valid_attributes) {
      {
        first_name: 'Tami',
        last_name: 'Kelley',
        email: 'auchiha.aopitho3l@handscuts.com',
        phone_number: '715-333-6687'
      }
    }

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }

      it 'creates a user' do
        expect(JSON.parse(response.body)['first_name']).to eq(valid_attributes[:first_name])
        expect(JSON.parse(response.body)['last_name']).to eq(valid_attributes[:last_name])
        expect(JSON.parse(response.body)['email']).to eq(valid_attributes[:email])
        expect(JSON.parse(response.body)['phone_number']).to eq(valid_attributes[:phone_number])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: { title: 'moo' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end

    context 'when there is a header with a frozen string' do
      before {
        post '/users',
          headers: { 'CONTENT_TYPE' => 'application/json'.freeze },
          params: valid_attributes.to_json
      }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when there is a cookie with a frozen string' do
      before {
        cookies['frozen'] = 'yogurt'.freeze
        post '/users',
          params: valid_attributes
      }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request body is a frozen string' do
      before {
        post '/users',
          headers: { 'CONTENT_TYPE' => 'application/json' },
          params: valid_attributes.to_json.freeze
      }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for GET /users/{user_id}.
  describe 'GET /users/:id' do
    before { get "/users/#{user_id}" }

    context 'when the record exists' do
      it 'returns the user' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for PUT /users/:id.
  describe 'PUT /users/:id' do
    # Valid payload.
    let(:valid_attributes) {
      {
        first_name: 'Darrin',
        last_name: 'Wells',
        email: 'luckybrooding@icloud.com',
        phone_number: '972-349-2044'
      }
    }

    context 'when the record exists' do
      before { put "/users/#{user_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /users/:id.
  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}" }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
  end
end
