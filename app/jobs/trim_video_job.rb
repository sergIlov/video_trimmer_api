class TrimVideoJob < ApplicationJob
  def perform(task_id)
    task = Task.find(task_id)
    if task.can_start_processing?
      task.start_processing!
      video_trimmer = VideoTrimmerEmulator.new(task.video.file.url, task.start_time, task.end_time)
      if video_trimmer.trim
        task.finish!
      else
        task.fail!
      end
    else
      logger.error('Job cannot be processed')
    end
  rescue Mongoid::Errors::DocumentNotFound
    logger.error('Job not found')
  end
end