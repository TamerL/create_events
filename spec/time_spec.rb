require './src/time'

describe '#is_formatted?' do

  it 'checks if the format of the passed time is correct' do
    expect(Time.is_formatted?('9:00am')).to eq(true)
  end

  it 'raises an error if the format is wrong' do
    expect do
      Time.is_formatted?('19:00am')
    end.to raise_error("please enter time in format like 09:00am")
  end
end