# Uploads video
class VideoUploader < CarrierWave::Uploader::Base
  def content_type_whitelist
    %r{video\/}
  end
end
