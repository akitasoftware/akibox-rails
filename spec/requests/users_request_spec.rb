require 'rails_helper'

RSpec.describe "Users", type: :request do
  # Initialize test data.
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }

  # Test suite for POST /v1/users.
  describe 'POST /v1/users' do
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
      before { post '/v1/users', params: valid_attributes }

      it 'creates a user' do
        expect(json['first_name']).to eq('Tami')
        expect(json['last_name']).to eq('Kelley')
        expect(json['email']).to eq('auchiha.aopitho3l@handscuts.com')
        expect(json['phone_number']).to eq('715-333-6687')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/v1/users', params: { title: 'moo' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  # Test suite for GET /v1/users/{user_id}.
  describe 'GET /v1/users/:id' do
    before { get "/v1/users/#{user_id}" }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
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

  # Test suite for PUT /v1/users/:id.
  describe 'PUT /v1/users/:id' do
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
      before { put "/v1/users/#{user_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /v1/users/:id.
  describe 'DELETE /v1/users/:id' do
    before { delete "/v1/users/#{user_id}" }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
  end
end
