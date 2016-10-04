class Oystercard
  attr_reader :balance, :limit, :in_use
  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90


  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @limit = BALANCE_LIMIT
    @in_use = false
  end

  def top_up(amount)
    amount = amount.to_i
    fail "Total balance should not be more than 90" if (@balance + amount) > @limit
    @balance += amount
  end

  def touch_in
    @in_use = true
  end

def deduct_balance(amount)
  amount = amount.to_i
  @balance -= amount
end
end
