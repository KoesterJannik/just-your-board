class Card < ApplicationRecord
  belongs_to :column
  belongs_to :assignee, class_name: "User", optional: true
  validates :name, presence: true

  validates :priority, presence: true

  enum :priority, {
    low: 0,
    medium: 1,
    high: 2
  }

  default_scope { includes(:column).order("cards.position ASC") }

  after_update :send_assignment_notification, if: :saved_change_to_assignee_id?

  private

  def send_assignment_notification
    puts "\e[42m\e[30m[ASSIGNMENT DEBUG]\e[0m \e[32mSENDING ASSIGNMENT NOTIFICATION\e[0m"
    puts "\e[42m\e[30m[ASSIGNMENT DEBUG]\e[0m \e[32mAssignee ID changed from: #{saved_change_to_assignee_id.first.inspect} to: #{saved_change_to_assignee_id.last.inspect}\e[0m"
    puts "\e[42m\e[30m[ASSIGNMENT DEBUG]\e[0m \e[32mCurrent assignee: #{assignee.inspect}\e[0m"
    return unless assignee.present?
    CardMailer.assignment_notification(self).deliver_later
  end
end
