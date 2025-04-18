class Column < ApplicationRecord
  belongs_to :board
  has_many :cards, dependent: :destroy
  # name is required
  validates :name, presence: true

end
