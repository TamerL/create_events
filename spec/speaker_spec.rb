require '../src/speaker'

context Speaker do
  describe '.initialize' do
    # initialize is a class method
    before do
      @speaker = Speaker.new("Mike")
    end
    it 'creates a speaker instance' do
      expect(@speaker.name).to eq('Mike')
    end
  end
end
