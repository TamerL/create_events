require '../src/event'
require '../src/time'


context Event do
  before do
    @speaker1 = double("Speaker", name: "Gandalf")
    @talk1 = double("Talk", name: 'Ruby Metaprogramming',
                            start_time: '9:00am', end_time: '10:00am',
                            event: @event, speaker_name: @speaker1.name)
    @speaker2 = double("Speaker", name: "Frodo")                            
    @talk2 = double("Talk", name: 'AI Applications with Ruby',
                            start_time: '9:30am', end_time: '10:30am',
                            event: @event, speaker_name: @speaker2.name)             
    @speaker3 = double("Speaker", name: "Aragorn")                            
    @talk3 = double("Talk", name: 'Finding Arwen in Ruby',
                            start_time: '11:30am', end_time: '12:30pm',
                            event: @event, speaker_name: @speaker3.name)                                                                         
  end

  describe '.initialize' do
    # initialize is a class method
    it 'takes a name and creates an event instance' do
      expect(Event.new("Rubyists").name).to eq('Rubyists')
    end

    it 'it assigns an array of talks to an event' do
      expect(Event.new("Rubyists").talks).to eq([])
    end
  end

  describe '#book_talk' do
  before do
    @event = Event.new("Rubyists")
  end
    it 'books a talk for the event if the time slot is free' do
      expect(@event.book_talk(talk: @talk1)).to eq("The talk is successfully booked")
    end

    it 'raises an error if the talk could not be booked' do
      @event.book_talk(talk: @talk1)
      expect do
        @event.book_talk(talk: @talk2)
        end.to raise_error(
          "The talk could not be booked, another talk already exist in that time.")
    end
  end

  describe '#sorted_print' do
  before do
    @event = Event.new("Rubyists")
  end
    it 'output the talks for an event sorted by the start time' do
      @event.book_talk(talk: @talk3)
      @event.book_talk(talk: @talk1)
      expect(@event.sorted_print).to eq(
        "9:00am - 10:00am\n  Ruby Metaprogramming presented by Gandalf\n"+
        "11:30am - 12:30pm\n  Finding Arwen in Ruby presented by Aragorn\n")
    end
  end

  describe '#is_busy?' do
  before do
    @event = Event.new("Rubyists")
  end
    # is_busy? is an instance method
    before do
      @event.book_talk(talk: @talk1)
    end
    it 'can check if the event already has a scheduled talk in that time interval' do
      expect(@event.is_busy?('9:30am', '10:30am')).to eq(true)
    end
  end
end
