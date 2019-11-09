class Event < ApplicationRecord
  STATES = %i[matching matched]

  belongs_to :user
  belongs_to :performer, class_name: 'User', optional: true
  has_one :chatroom, dependent: :destroy

  validates :title, presence: true
  # validates :place, presence: true
  # validates :detail_place, presence: true
  # validates :time_limit, presence: true
  # validates :reward, numericality: {greater_than_or_equal_to: 0}

  enum state: STATES

  acts_as_taggable
end
