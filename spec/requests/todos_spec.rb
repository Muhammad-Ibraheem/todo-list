# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  # initialize test data

  let(:user) { create(:user) }
  let!(:user_token) { token_generator(user.id) }
  let!(:headers) { { 'Authorization' => user_token } }
  let!(:todos) { create_list(:todo, 5, user: user) }
  let!(:todo_id) { todos.first.id }

  before do
    user.update user_token: user_token
  end

  # GET /todo
  describe 'GET /todos' do
    before do
      get '/api/v1/todos', params: {}, headers: headers
    end

    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # POST /todo

  describe 'POST/todos' do
    let(:valid_attributes) do
      { title: 'Movie', user_id: user.id }
    end

    context 'when the request is valid' do
      before do
        post '/api/v1/todos', params: valid_attributes, headers: headers
      end
      it 'creates a todo' do
        expect(json['title']).to eq('Movie')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }

      before do
        post '/api/v1/todos', params: invalid_attributes, headers: headers
      end

      it 'returns a validations faliure message' do
        expect(response.body).to include('is too short (minimum is 3 characters)')
      end
    end
  end

  # DELETE /todo/id

  describe 'DELETE/todos/:id' do
    before do
      delete "/api/v1/todos/#{todo_id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
