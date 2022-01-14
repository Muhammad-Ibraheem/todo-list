# frozen_string_literal: true

class TodosRepresenter
  def initialize(todos)
    @todos = todos
  end

  def as_json
    todos
  end

  private

  attr_reader :todos
end
