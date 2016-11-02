class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  include Workflow
  include Mongoid::Workflow

  field :start_time, type: Integer, default: 0
  field :end_time, type: Integer, default: 0
  field :state

  belongs_to :user
  belongs_to :video

  validates :start_time, numericality: { greater_than_or_equal_to: 0 }
  validates :end_time, presence: true, numericality: { greater_than: proc { |task| task.start_time || 0 } }

  default_scope proc { order(created_at: :desc) }

  after_create :schedule!

  workflow_column :state
  workflow do
    state :new do
      event :schedule, transitions_to: :scheduled
    end
    state :scheduled do
      event :start_processing, transitions_to: :processing
    end
    state :processing do
      event :finish, transitions_to: :done
      event :fail, transitions_to: :failed
    end
    state :failed do
      event :schedule, transitions_to: :scheduled
    end
    state :done
  end

  def url
    video.file.url
  end

  def duration
    end_time - start_time
  end

  def schedule
    TrimVideoJob.set(wait: 2.seconds).perform_later(id.to_s)
  end
end
