class User < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  validates_presence_of :email
  validates_inclusion_of :gender, in: [ 'm', 'f' ]

  before_validation :normalize_gender_field

  def get_project_membership(project_id)
    self.memberships.find_by project_id: project_id
  end

  def self.create_or_update( data )
    user = self.find_by email: data[:email]

    if user
      user.update_attributes data
    else
      user = self.create data
    end
    # Return affected record
    user
  end

  private

  def normalize_gender_field
    if gender.downcase[0] == 'm'
      self.gender = 'm'
    else
      self.gender = 'f'
    end
  end
end
