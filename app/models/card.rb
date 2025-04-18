class Card < ApplicationRecord
  belongs_to :column
  validates :name, presence: true
  validates :description, presence: true
  validates :priority, presence: true

  enum :priority, {
    low: 0,
    medium: 1,
    high: 2
  }

  default_scope { includes(:column).order('cards.position ASC') }
end
