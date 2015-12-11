class MatrixFactory

  def initialize(string)
    @string = string
  end

  def matrix
    @matrix ||= generate_matrix
  end


  private

  attr_reader :string

  def generate_matrix
    rows.each_with_object([]) do |row, arr|
      arr << clean_up(row)
    end
  end

  def rows
    arr = string.split(/\n/)
    arr.delete_at(3)
    arr.delete_at(6)
    arr
  end

  def clean_up(row_string)
    row_string.gsub("|","")
      .split(" ")
      .map { |num| num.to_i }
      .map { |num| num == 0 ? nil : num }
  end
end
