class Cell

  def initialize(value = nil)
    @state = set_state(value)
  end

  def value
    solved? ? state[0] : nil
  end

  def possibilities
    solved? ? nil : state
  end

  def remove!(n)
    able_to_remove = can_take_action_on(n)
    state.delete(n) if able_to_remove
    able_to_remove
  end

  def solve!(n)
    able_to_solve = can_take_action_on(n)
    @state = [n] if able_to_solve
    able_to_solve
  end

  private

  attr_reader :state

  def solved?
    state.length == 1
  end

  def can_take_action_on(n)
    !solved? && state.include?(n)
  end

  def set_state(value)
    if value.nil?
      (1..9).to_a
    else
      [value]
    end
  end
end
