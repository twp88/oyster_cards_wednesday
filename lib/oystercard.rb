class Oystercard
  attr_reader :balance, :limit
  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @limit = BALANCE_LIMIT
  end

  def top_up(amount)
    amount = amount.to_i
    fail "Total balance should not be more than 90" if (@balance + amount) > @limit
    @balance += amount
  end




def deduct_balance(amount)
  amount = amount.to_i
  @balance -= amount
end
end
