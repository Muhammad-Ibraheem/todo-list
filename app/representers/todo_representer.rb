# frozen_string_literal: true

class TodoRepresenter
  def initialize(todo)
    @todo = todo
  end

  def as_json
    todo
  end

  private

  attr_reader :todo
end
