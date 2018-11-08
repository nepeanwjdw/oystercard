require 'oystercard'
require 'journey'

describe Journey do
  let(:oystercard) { double :oystercard }

  min_b = Oystercard::MINIMUM_BALANCE
  min_c = Oystercard::MINIMUM_CHARGE
  max_b = Oystercard::MAXIMUM_BALANCE

  describe 'a group of tests that require a top_up' do
    before do
      oystercard.top_up(min_b)
    end
    describe 'a group of tests that also require touch_in' do
      before do
        oystercard.touch_in(entry_station)
      end
      describe '#touch_out' do
        context 'when oystercard is already in a journey' do
          it 'when touched out it changes entry_station to nil' do
            oystercard.touch_out(exit_station)
            expect(subject).not_to be_in_journey
          end
          context 'when oystercard is already in a journey' do
            it 'stores exit station' do
              subject.touch_out(exit_station)
              expect(subject.exit_station).to eq exit_station
            end
          end
        end
      end
      describe '#touch_in' do
        context 'when oystercard is not already in a journey' do
          it 'stores the entry station' do
            expect(subject.entry_station).to eq entry_station
          end
        end
      end
      describe '#update_journeys' do
        let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

        it 'stores a journey' do
          subject.touch_out(exit_station)
          expect(subject.journeys).to include journey
        end
      end
    end
  end
end
