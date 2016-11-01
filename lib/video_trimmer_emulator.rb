# Emulator
class VideoTrimmerEmulator
  def initialize(_url, _start_time, _end_time)
  end

  def trim
    # sleep(Random.rand(20.seconds..2.minutes))
    sleep 3
    [true, false].sample
  end
end
