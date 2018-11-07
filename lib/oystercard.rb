class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @in_transit = false
  end

  def top_up(amount)
    message = "The maximum balance is £#{MAXIMUM_BALANCE}"
    fail message if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_transit
  end

  def touch_in
    fail 'Insufficient balance to touch in' if @balance < MINIMUM_BALANCE
    @in_transit = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_transit = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
