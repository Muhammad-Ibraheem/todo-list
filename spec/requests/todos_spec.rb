# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 5, user: user) }
  let(:todo_id) { todos.first.id }

  # GET /todo
  describe 'GET /todos' do
    before { get '/api/v1/todos' }

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
      before { post '/api/v1/todos', params: valid_attributes }

      it 'creates a todo' do
        expect(json['title']).to eq('Movie')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/api/v1/todos', params: invalid_attributes }

      it 'returns a validations faliure message' do
        expect(response.body).to include('is too short (minimum is 3 characters)')
      end
    end
  end

  # DELETE /todo/id

  describe 'DELETE/todos/:id' do
    before { delete "/api/v1/todos/#{todo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
