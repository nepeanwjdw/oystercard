class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    message = "The maximum balance is £#{MAXIMUM_BALANCE}"
    fail message if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail 'Insufficient balance to touch in' if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @exit_station = station
    update_journeys
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def update_journeys
    @journeys << {entry_station: @entry_station, exit_station: @exit_station}
  end
end
