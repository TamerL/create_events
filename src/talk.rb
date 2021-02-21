class Talk
  attr_reader :name
  attr_reader :event_name
  attr_reader :speaker_name
  attr_reader :start_time
  attr_reader :end_time

  def initialize(name:, start_time:, end_time:, event:, speaker:)
    @event_name = event.name
    @name = name
    @start_time = start_time
    @end_time = end_time
    @speaker_name = speaker.name
  end
end
