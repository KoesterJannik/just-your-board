class Invitation < ApplicationRecord
  belongs_to :board

  # generate a token before saving
  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(16)
  end
end
