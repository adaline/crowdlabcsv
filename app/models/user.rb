class User < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  validates_presence_of :email
  validates_inclusion_of :gender, in: [ 'm', 'f' ]

  before_validation :normalize_gender_field

  private

  def normalize_gender_field
    if gender.downcase[0] == 'm'
      self.gender = 'm'
    else
      self.gender = 'f'
    end
  end
end
