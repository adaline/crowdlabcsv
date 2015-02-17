class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  def attached_data=(data)
    self.extra = data.to_json
  end

  def attached_data
    JSON.parse(self.extra)
  end
end
