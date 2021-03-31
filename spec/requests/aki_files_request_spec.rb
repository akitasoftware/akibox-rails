require 'rails_helper'

RSpec.describe "AkiFiles", type: :request do
  # Initialize test data.
  let!(:user) { create(:user) }
  let!(:aki_files) { create_list(:aki_file, 20, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { aki_files.first.id }

  # Test suite for POST /users/:user_id/aki_files
  describe 'POST /users/:user_id/aki_files' do
    let(:valid_attributes) {
      {
        filename: 'donor.sty',
        contents: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ' \
                  'sed do eiusmod tempor incididunt ut labore et dolore ' \
                  'magna aliqua.',
      }
    }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/aki_files", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/aki_files", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  # Test suite for GET /users/:user_id/aki_files/:id
  describe 'GET /users/:user_id/aki_files/:id' do
    before { get "/users/#{user_id}/aki_files/#{id}" }

    context 'when file exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(JSON.parse(response.body)['id']).to eq(id)
      end
    end

    context 'when file does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find AkiFile/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/aki_files/:id
  describe 'PUT /users/:user_id/aki_files/:id' do
    let(:valid_attributes) {
      {
        filename: 'significant.cxk',
        contents: 'Ut enim ad minim veniam, quis nostrud exercitation ' \
                  'ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      }
    }

    before { put "/users/#{user_id}/aki_files/#{id}", params: valid_attributes }

    context 'when file exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the file' do
        updated_file = AkiFile.find(id)
        expect(updated_file.filename).to eq(valid_attributes[:filename])
        expect(updated_file.contents).to eq(valid_attributes[:contents])
      end
    end

    context 'when the file does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find AkiFile/)
      end
    end
  end

  # Test suite DELETE POST /users/:user_id/aki_files/:id
  describe 'DELETE /users/:user_id/aki_files/:id' do
    before { delete "/users/#{user_id}/aki_files/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
