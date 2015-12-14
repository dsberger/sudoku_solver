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
    state.delete(n) unless solved?
  end

  def solve!(n)
    @state = [n] if state.include?(n)
  end

  private

  attr_reader :state

  def solved?
    state.length == 1
  end

  def set_state(value)
    if value.nil?
      (1..9).to_a
    else
      [value]
    end
  end
end
