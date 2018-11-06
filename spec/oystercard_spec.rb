require 'oystercard'

describe Oystercard do
  it 'should have a balance' do
    expect(subject.balance).to eq 0
  end
  describe '#top_up' do
    it 'should be to recieve top up from user' do
    subject.top_up(10)
    expect(subject.balance).to eq 10
    end

    it 'should have a maximum balance of £90' do
      subject.top_up(90)
      message = 'The maximum balance is £90'
      expect { subject.top_up(1) }.to raise_error(message)
    end

  end
end
