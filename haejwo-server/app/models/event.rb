class Event < ApplicationRecord
  STATES = %i[matching matched]

  belongs_to :user
  belongs_to :building, counter_cache: true
  belongs_to :performer, class_name: 'User', optional: true
  has_one :chatroom, dependent: :destroy

  validates :title, presence: true
  validates :detail_place, presence: true
  validates :time_limit, presence: true
  validates :reward, numericality: {greater_than_or_equal_to: 0}

  scope :not_performed, -> { where(performer_id: nil) }
  scope :performed, -> { where.not(performer_id: nil) }

  # validate :method

  enum state: STATES

  acts_as_taggable

  def self.reward_selectors
    num_arr = []
    (1..1000).each do |i|
      num_arr.push(i * 500)
    end
    num_arr
  end

  def method
    errors.add(:chatroom, '심부름에 관련된 채팅방은 한 개여야 합니다.') ## if ### >= 2
  end
end
