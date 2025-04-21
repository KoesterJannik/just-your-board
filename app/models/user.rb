class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :board_users, dependent: :destroy
  has_many :shared_boards, through: :board_users, source: :board
  has_many :assigned_cards, class_name: "Card", foreign_key: "assignee_id"
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
