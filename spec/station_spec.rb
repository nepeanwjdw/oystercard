require 'station'

describe Station do

  subject { described_class.new("Old Street", 1) }

  it 'should record the station name' do
    expect(subject.name).to eq "Old Street"
  end

  it 'should record the station zone' do
    expect(subject.zone).to eq 1
  end
end
