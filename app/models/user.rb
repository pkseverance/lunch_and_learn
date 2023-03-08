class User < ApplicationRecord
  before_validation :generate_api_key
  validates_presence_of :name, :email
  validates :email, uniqueness: true
  has_many :favorites

  private
  def generate_api_key
    if self.api_key == nil
      self.api_key = Random.hex
    end
  end
end