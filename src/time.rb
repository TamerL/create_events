require 'pry'
class Time

  def self.to_minutes(time)
    # binding.pry
    minutes = time.split(":")[0].to_i * 60 + time.split(":")[1].to_i
    time.match(/am/) ? minutes : (minutes + 720)
  end

  def self.is_formatted?(time)
    # binding.pry
    if (time =~ (/^([1-9]|1[0-2])\:[0-5][0-9][a,p,A,P][M,m]$/))
      return true
    end
    raise "please enter time in format like 09:00am"
  end

end