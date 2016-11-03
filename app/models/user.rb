class User
  include Mongoid::Document

  field :token

  has_many :videos, dependent: :destroy, inverse_of: :user
  has_many :tasks, dependent: :destroy

  before_create :generate_token

  private
  
  def generate_token
    self.token = SecureRandom.hex(20)
  end
end
