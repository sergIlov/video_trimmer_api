class V1::VideosController < ApplicationController
  before_action :authenticate!
  
  def index
    @videos = current_user.videos
  end
  
  def create
    video = current_user.videos.build(params.permit(:file))
    if video.save
      redirect_to video_path(video)
    else
      render_validation_errors video.errors
    end
  end
  
  def show
    @video = current_user.videos.find(params[:id])
  end
end
