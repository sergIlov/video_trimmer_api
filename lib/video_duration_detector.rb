# Detects video duration
class VideoDurationDetector
  PATTERN = /duration: ([0-9]{2}:[0-9]{2}:[0-9]{2})/i
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def detect
    ffmpeg_output = `#{ffmpeg_bin} -i "#{filename}" 2>&1`
    PATTERN.match(ffmpeg_output)[1].split(':').map(&:to_i).zip([3600, 60, 1]).sum { |a, b| a * b }
  rescue
    0
  end

  protected

  def ffmpeg_bin
    '/usr/bin/ffmpeg'
  end
end
