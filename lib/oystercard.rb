require_relative 'journey'
require_relative 'station'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance
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
    !!@journey
  end

  def touch_in(entry_station)
    touch_out("Unknown Station") if in_journey?
    fail 'Insufficient balance to touch in' if @balance < MINIMUM_BALANCE
    @journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    @journey.finish(exit_station)
    update_journeys
    deduct
    @journey = nil
  end

  private

  def deduct
    @balance -= @journey.fare
  end

  def update_journeys
    @journeys << @journey.journey
  end
end
