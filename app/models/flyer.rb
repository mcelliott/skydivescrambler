class Flyer < ActiveRecord::Base
  belongs_to :user

  validates :name,  presence: true, length: { maximum: 50 }
  validates :user_id,  presence: true
  validates :hours, presence: true, numericality: true

  validates_numericality_of :hours, greater_than_or_equal_to: 0
  validates :email, email: true

  paginates_per 20
end
