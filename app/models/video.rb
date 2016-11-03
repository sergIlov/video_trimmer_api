class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :file

  belongs_to :user, inverse_of: :videos
  has_many :tasks, inverse_of: :task

  validates :file, presence: true

  mount_uploader :file, VideoUploader

  default_scope proc { order(created_at: :desc) }
end
