class Building < ApplicationRecord
  has_many :events, dependent: :destroy
end
