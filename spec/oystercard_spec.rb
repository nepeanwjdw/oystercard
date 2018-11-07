require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  min_b = Oystercard::MINIMUM_BALANCE
  min_c = Oystercard::MINIMUM_CHARGE
  max_b = Oystercard::MAXIMUM_BALANCE
  it 'should have a balance' do
    expect(subject.balance).to eq 0
  end
  describe 'a group of tests that require a top_up' do
    before do
      subject.top_up(min_b)
    end
    describe '#top_up' do
      it 'should be to recieve top up from user' do
        expect(subject.balance).to eq min_b
      end
    end

    describe 'a group of tests that also require touch_in' do
      before do
        subject.touch_in(station)
      end
      describe '#touch_out' do
        it 'when touched out it changes entry_station to nil' do
          subject.touch_out
          expect(subject).not_to be_in_journey
        end
        it 'when touched out it deducts the minimum charge' do
          expect{ subject.touch_out }.to change{ subject.balance }.by(-min_c)
        end
      end
      describe '#touch_in' do
        it 'stores the entry station' do
          expect(subject.entry_station).to eq station
        end
      end
    end
  end

  it 'should have a maximum balance of £90' do
    subject.top_up(max_b)
    message = "The maximum balance is £#{max_b}"
    expect { subject.top_up(1) }.to raise_error(message)
  end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  describe '#touch_in' do
    it 'when below the minimum balance does not let you touch in' do
      message = 'Insufficient balance to touch in'
      expect{ subject.touch_in(station) }.to raise_error message
    end
  end
end
