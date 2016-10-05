class Oystercard
  attr_reader :balance, :limit, :in_use, :entry_station, :station, :MINIMUM_FARE, :journeys, :recorded_journeys
  DEFAULT_BALANCE = 5
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @limit = BALANCE_LIMIT
    @entry_station = nil
    @journeys = []
    @recorded_journeys = {}
  end

  def top_up(amount)
    amount = amount.to_i
    fail "Total balance should not be more than 90" if (@balance + amount) > @limit
    @balance += amount
  end

  def touch_in
    raise "Card already in use, must touch out first" if in_journey? == true
    raise "Not enough funds" if @balance < 1
      @entry_station = :awesome_coffwee
      @journeys << :awesome_coffwee
  end

  def touch_out(min_fare = MINIMUM_FARE)
    raise "Already touched out" if in_journey? == false
      @entry_station = nil
      @journeys << :exit_station
      deduct_balance(min_fare)
  end

  def in_journey?
    return true if @entry_station != nil
      false
  end

private
def deduct_balance(amount)
  @balance -= amount
end
end
