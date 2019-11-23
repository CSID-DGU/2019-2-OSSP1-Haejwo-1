class Report < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :content, presence: true
end
