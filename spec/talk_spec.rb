require './src/talk'
require 'pry'

describe Talk do
  context 'Given an event is arranged and a speaker is present' do
    before do
      @event = double("Talk", name: 'Rubyists')
      @speaker = double("Speaker", name: 'Kunal')
    end

    describe '.initialize' do
      # initialize is a class method

      it 'has an event name' do
        expect(Talk.new(name: 'Ruby Metaprogramming', 
        start_time: '9:00am', end_time: '10:00am', 
        event: @event, speaker: @speaker).event_name).to eq('Rubyists')
      end
      it 'has an speaker name' do
        @talk1 = Talk.new(name: 'Ruby Metaprogramming', 
        start_time: '9:00am', end_time: '10:00am', 
        event: @event, speaker: @speaker)
        expect(@talk1.speaker_name).to eq('Kunal')
      end
      it 'has an start time' do
        @talk1 = Talk.new(name: 'Ruby Metaprogramming', 
        start_time: '9:00am', end_time: '10:00am', 
        event: @event, speaker: @speaker)        
        expect(@talk1.start_time).to eq('9:00am')
      end
      it 'has an end time' do
        @talk1 = Talk.new(name: 'Ruby Metaprogramming', 
        start_time: '9:00am', end_time: '10:00am', 
        event: @event, speaker: @speaker)
        expect(@talk1.end_time).to eq('10:00am')
      end
    end
  end
end
