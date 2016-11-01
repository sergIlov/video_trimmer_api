module ApplicationHelper
  def format_duration(seconds)
    (1..3).to_a.map { seconds, d = seconds.divmod(60); d }.reverse.map { |number| number.to_s.rjust(2, '0') }.join(':')
  end
end
