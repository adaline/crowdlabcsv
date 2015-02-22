class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  def attached_data=(data)
    self.extra = data.to_json
  end

  def attached_data
    JSON.parse(self.extra)
  end

  def self.create_or_update( data )
    native_data = data.except(:attached_data)

    membership = self.find_by native_data
    membership = self.new(native_data) unless membership

    membership.attached_data = data[:attached_data]
    membership.save
    # Return affected record
    membership
  end
end
