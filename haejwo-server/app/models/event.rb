class Event < ApplicationRecord
  STATES = %i[matching matched]

  belongs_to :user
  belongs_to :building, counter_cache: true
  belongs_to :performer, class_name: 'User', optional: true

  has_many :chatrooms, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :title, presence: true
  validates :detail_place, presence: true
  validates :time_limit, presence: true
  validates :reward, numericality: {greater_than_or_equal_to: 0}

  # validate :method

  enum state: STATES

  acts_as_taggable

  def to_s
    title
  end

  def method
    errors.add(:chatroom, '심부름에 관련된 채팅방은 한 개여야 합니다.') ## if ### >= 2
  end
end
