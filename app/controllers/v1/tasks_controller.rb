class V1::TasksController < ApplicationController
  before_action :authenticate!
  
  def index
    @tasks = current_user.tasks
  end
  
  def create
    task = current_user.tasks.build(params.permit(:start_time, :end_time, :video_id))
    if task.save
      redirect_to task_path(task)
    else
      render_validation_errors(task.errors)
    end
  end
  
  def restart
    task = current_user.tasks.find(params[:id])
    if task.can_schedule?
      task.schedule!
      redirect_to task_url(task)
    else
      render_error 'Task cannot be scheduled'
    end
  end
  
  def show
    @task = current_user.tasks.find(params[:id])
  end
end