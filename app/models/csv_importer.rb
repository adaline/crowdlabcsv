require 'csv'

# Assumptions for this test's convinience:
# The csv has a header row, which is the first one
# Dates are in correct format

class CsvImporter
  def initialize(csv_content)
    @data = CSV.parse(csv_content)
  end

  def header
    @data.first
  end

  def data
    @data.drop(1)
  end

  def self.expected_fields_in_order
    %w(name email password born_on gender).each_with_index.map {|field, index| [field, index]}
  end

  def self.fake_csv(number)
    CSV.generate do |csv|
      # Header (the fields are intentionally in the wrong order)
      csv <<   %w(gender name email password born_on)
      # Data
      for index in 0..number
        csv << [
          [true, false].sample ? 'm' : 'f',
          Faker::Name.name,
          Faker::Internet.email,
          Faker::Internet.password,
          Faker::Time.between(2.years.ago, 1.year.ago)
        ]
      end
    end
  end

  def import_data(project_id, column_order)
    mapped_data = map_data(column_order)
    save_data(project_id, mapped_data)
  end

  private

  def map_data(column_order)
    # Ugly but fast solution
    data.map do |row|
      new_array = []
      (0..column_order.size-1).each {|i| new_array[column_order[i]] = row[i]}
      new_array
    end
  end

  def save_data(project_id, mapped_data)
    project = Project.find_by id: project_id
    mapped_data.each do |row|
      existing_user = project.users.find_by email: row[1]
      if existing_user
        existing_user.update_attributes row_to_hash(row)
      else
        project.users.create row_to_hash(row)
      end
    end
  end

  def row_to_hash(row)
    {name: row[0], email: row[1], password: row[2], born_on: row[3], gender: row[4]}
  end

end
