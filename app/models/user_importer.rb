class UserImporter
  def initialize(reader)
    @reader = reader
  end

  def self.expected_fields_in_order
    %w(name email password born_on gender extra).each_with_index.map {|field, index| [field, index]}
  end

  def import_data(project_id, column_order)
    mapped_data = map_data(column_order)
    save_data(project_id, mapped_data)
  end

  private

  def map_data(column_order)
    header_fields = @reader.header

    @reader.data.map do |row|
      new_array = []
      extras = {}
      (0..column_order.size-1).each do |i|
        # Add value based on mapping
        new_array[column_order[i]] = row[i]
        # Move extra fields out
        extras[header_fields[i]] = row[i] if column_order[i] == 5
      end
      # Add extras as the last field in mapped row
      new_array[5] = extras
      # Return it
      new_array
    end
  end

  def save_data(project_id, mapped_data)
    project = Project.find_by id: project_id

    mapped_data.each do |row|
      # Create/update user with mapped data
      user_hash = {name: row[0], email: row[1], password: row[2], born_on: row[3], gender: row[4]}
      user = User.create_or_update user_hash

      # Create/update memebersip records and update extra fields
      membership_hash = {user_id: user.id, project_id: project.id, attached_data: row[5]}
      membership = Membership.create_or_update membership_hash
    end
  end

end
