class Participant < ActiveRecord::Base
  belongs_to :category
  belongs_to :flyer
  belongs_to :event
  belongs_to :user

  has_many :team_participants, dependent: :destroy
  has_one :payment, dependent: :destroy

  delegate :name, to: :flyer, prefix: true

  validates :flyer_id,    presence: true
  validates :event_id,    presence: true
  validates :category_id, presence: true
  validates :user_id,     presence: true

  scope :category_type, ->(category) { where(category: category) }

  def self.participant_number(event)
    current_event_participants = event.participants
    existing_number = [*1..current_event_participants.count + 1] - event.participants.map(&:number)

    if existing_number.present?
      existing_number.first
    else
      current_event_participants.count + 1
    end
  end
end
