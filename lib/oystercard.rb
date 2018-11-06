class Oystercard

MAXIMUM_BALANCE = 90
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

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_transit
  end

  def touch_in
    @in_transit = true
  end

  def touch_out
    @in_transit = false
  end
end
