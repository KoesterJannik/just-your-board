class Board < ApplicationRecord
  belongs_to :user
  has_many :board_users, dependent: :destroy
  has_many :users, through: :board_users
  has_many :columns, dependent: :destroy

  validates :title, presence: true
end
