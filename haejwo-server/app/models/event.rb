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
    errors.add(:free_standard, '조건부 무료배송은 무료배송 기준을 설정해주셔야합니다.') ## if ### >= 2
  end
end
