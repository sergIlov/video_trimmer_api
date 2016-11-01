class User
  include Mongoid::Document

  field :token

  has_many :videos, dependent: :destroy
  has_many :tasks, dependent: :destroy

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.hex(20)
  end
end
