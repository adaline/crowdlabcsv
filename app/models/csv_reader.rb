require 'csv'

class CsvReader
  attr_reader :header, :data

  def initialize(csv_content)
    input = CSV.parse(csv_content)
    @header = input.first
    @data = input.drop(1)
  end
end
