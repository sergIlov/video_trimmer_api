class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :file

  belongs_to :user
  has_many :tasks

  validates :file, presence: true

  mount_uploader :file, VideoUploader

  default_scope proc { order(created_at: :desc) }
end
