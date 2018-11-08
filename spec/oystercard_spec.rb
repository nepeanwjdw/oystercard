require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  min_b = Oystercard::MINIMUM_BALANCE
  min_c = Oystercard::MINIMUM_CHARGE
  max_b = Oystercard::MAXIMUM_BALANCE

  describe 'initialize' do
    it 'should have a balance' do
      expect(subject.balance).to eq 0
    end

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end

    it 'should have a maximum balance of £90' do
      subject.top_up(max_b)
      message = "The maximum balance is £#{max_b}"
      expect { subject.top_up(1) }.to raise_error(message)
    end
  end

  describe '#touch_in' do
    it 'when below the minimum balance does not let you touch in' do
      message = 'Insufficient balance to touch in'
      expect{ subject.touch_in(entry_station) }.to raise_error message
    end
  end

  describe 'a group of tests that require a top_up' do
    before do
      subject.top_up(min_b)
    end
    describe '#top_up' do
      it 'should be to receive top up from user' do
        expect(subject.balance).to eq min_b
      end
    end

    describe 'a group of tests that also require touch_in' do
      before do
        subject.touch_in(entry_station)
      end
      describe '#touch_out' do
        context 'when oystercard is already in a journey' do
          it 'when touched out it deducts the minimum charge' do
            expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-min_c)
          end
        end
      end
    end
  end
end
