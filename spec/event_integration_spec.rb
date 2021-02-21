require './src/speaker'
require './src/event'
require './src/talk'
require './src/time'
require 'pry'

describe 'The event booking app' do
  it 'can create events' do
    # @event = Event.new('TechTalk')
    expect(Event.new('TechTalk').name).to eq('TechTalk')
  end
  it 'can create speakers for the event' do
    # @speaker = Speaker.new('Gandalf')
    expect(Speaker.new('Gandalf').name).to eq('Gandalf')
  end

  it 'can book a talk in the event for a speaker' do
    @event = Event.new('TechTalk')
    @speaker = Speaker.new('Gandalf')
    expect(Talk.new(name: 'The Lord of The Codes', start_time: '9:00am',
                    end_time: '10:00am', event: @event, 
                    speaker: @speaker).name).to eq(
                    "The Lord of The Codes")
  end

  context 'when an event is happening and speakers are present,' do
    before do
      @event = Event.new('TechTalk')
      @speaker1 = Speaker.new('Gandalf')
      @speaker2 = Speaker.new('Aragorn')
      @speaker3 = double("Speaker", name: "Frodo") 
      @talk1 = Talk.new(name: 'Lord of The Codes', start_time: '9:00am',
                end_time: '10:00am', event: @event, speaker: @speaker1)
      @talk2 = Talk.new(name: 'Finding Arwen in Ruby', start_time: '9:30am',
                end_time: '12:30pm', event: @event, speaker: @speaker2) 
      @talk3 = Talk.new(name: 'Finding Arwen in Ruby', start_time: '10:00am',
                end_time: '12:30pm', event: @event, speaker: @speaker2)   
    end
    it 'can book a talk in the event' do
      expect(@event.book_talk(talk: @talk1)).to eq("The talk is successfully booked")
    end
    it 'when the time is not available, a talk can not be booked' do
      # binding.pry 
      @event.book_talk(talk: @talk1)
      expect do
        @event.book_talk(talk: @talk2)
      end.to raise_error(
        "The talk could not be booked, another talk already exist in that time.")
    end
    it 'can book a talk in the event if the time is available' do
      @event.book_talk(talk: @talk1)
      expect(@event.book_talk(talk: @talk3)).to eq("The talk is successfully booked")
    end
  end
end
