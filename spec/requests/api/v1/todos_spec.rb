# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/todos', type: :request do
  path '/api/v1/todos' do
    post 'Create  todo' do
      tags 'Todo'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :todo, in: :body,
                schema: {
                  type: :object,
                  properties: {
                    title: { type: :string },
                    completed_at: { type: :string, format: :datetime },
                    expected_completion_time: { type: :string, format: :time },
                    remind_at: { type: :string, format: :datetime },
                    reminder_frequency: { type: :string },
                    last_reminder_sent_at: { type: :string, format: :datetime }
                  },
                  required: ['title']
                }

      response '201', 'todo created' do
        let(:todo) { { title: 'Movie' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:todo) { { title: 'Movie' } }
        run_test!
      end
    end
  end

  path '/api/v1/todos/:id' do
    get 'Get todo' do
      tags 'todos'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      response '200', 'todos found' do
        let(:id) { Todo.create(title: 'title') }
        run_test!
      end

      response '404', 'blog not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path 'api/v1/todos/:id' do
    delete 'delete todo' do
      tags 'todo'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      response '204', 'todo deleted' do
        let(:id) { Todo.create(title: 'title') }
        run_test!
      end
      response '404', :not_found do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
