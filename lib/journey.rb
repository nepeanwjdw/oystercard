class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station
  attr_reader :journey

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @journey = {entry_station: @entry_station, exit_station: exit_station}
    @entry_station = nil
  end

  def fare
    return PENALTY_FARE if @journey[:entry_station] == "Unknown Station"
    return PENALTY_FARE if @journey[:exit_station] == "Unknown Station"
  end

  def complete?
    !@entry_station
  end

end
