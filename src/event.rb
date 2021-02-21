require 'pry'

class Event
  attr_reader :name
  attr_reader :talks

  def initialize(name)
    @name = name
    @talks = []
  end

  def book_talk(talk:)
    # binding.pry
    if !is_busy?(talk.start_time,talk.end_time)
    @talks.push([talk.start_time,talk.end_time,talk.name,talk.speaker_name])
    "The talk is successfully booked"
    else 
      raise "The talk could not be booked, another talk already exist in that time."
    end
  end

  def is_busy?(start_time, end_time)
    # binding.pry
    new_talk_start_min = Time.to_minutes(start_time)
    new_talk_end_min = Time.to_minutes(end_time)
    self.talks.each { |booked_talk|
      booked_talk_start_min = Time.to_minutes(booked_talk[0])
      booked_talk_end_min = Time.to_minutes(booked_talk[1])
      if (booked_talk_start_min <= new_talk_start_min && new_talk_start_min < booked_talk_end_min ||
        booked_talk_start_min < new_talk_end_min && new_talk_end_min <= booked_talk_end_min)
        return true
      end
    }
    false
  end

  def sorted_print
    # binding.pry
    talks.sort_by!{|talk| Time.to_minutes(talk[0])}
    print = talks.collect {|t| 
      "#{t[0]} - #{t[1]}\n  #{t[2]} presented by #{t[3]}\n"
  }
    puts print.join
    print.join
  end
end
