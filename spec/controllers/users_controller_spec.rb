require 'rails_helper'

RSpec.describe UsersController do
  # Test suite for POST /users.
  describe 'POST /users' do
    # Valid user payload.
    let(:valid_attributes) {
      {
        first_name: 'Tami',
        last_name: 'Kelley',
        email: 'auchiha.aopitho3l@handscuts.com',
        phone_number: '715-333-6687'
      }
    }

    context 'when the request is valid' do
      before { post 'create', params: valid_attributes }

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
      before { post 'create', params: { title: 'moo' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end
end
