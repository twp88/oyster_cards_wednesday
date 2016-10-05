require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:awesome_coffwee) {double :station}


  describe "#balance" do

    it "expects a default balance of 5" do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it "expects a different balance value than the default value" do
      oyster = Oystercard.new(20)
      expect(oyster.balance).to eq 20
    end
  end

  describe "#top_up" do
    before do
      @balance = 5
    end

    it "allows the card to top-up certain amount" do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end

      it "expects the balance to increase by top-up amount" do
        expect{oystercard.top_up(16)}.to change {subject.balance}.by 16
      end

      it "sets limit for oyster at 90" do
        expect(oystercard.balance).to be <= oystercard.limit
      end
      it "raises and error if balance is more than 90" do
        amount = 100
          expect{oystercard.top_up(amount)}.to raise_error "Total balance should not be more than 90"
      end
end

describe '#touch_in' do
  it "allows a user to touch in at a station" do
    oystercard.touch_in
    expect(oystercard.in_journey?).to eq true#
  end

  it "raises an error if card is already in use" do
    oystercard.touch_in
    expect{ oystercard.touch_in }.to raise_error "Card already in use, must touch out first"
  end
  it  "tests to see if passenger is in journey" do
    oystercard.touch_in
    expect(oystercard.in_journey?).to eq true#
end

  it "does not allow to touch in when balance is less than £1" do
    oyster1 = Oystercard.new(0)
    expect{oyster1.touch_in}.to raise_error "Not enough funds"
  end

  it "saves the origin station" do
    oystercard.touch_in
    expect(oystercard.entry_station).not_to eq nil
  end
end

# describe "#deduct_balance" do
#   it "deducts an amount from the standing balance" do
#     expect{ oystercard.touch_out }.to change {subject.balance}.by -1
#   end
# end

describe '#touch_out' do
  it "allows a user to touch out at a station" do
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard.in_journey?).to eq false#
  end

  it "raises an error if card is not in use" do
    expect(oystercard.in_journey?).to eq false#
    expect{ oystercard.touch_out }.to raise_error "Already touched out"
  end

  it "uses the deduct method to deduct the minimum fare when you touch out" do
    oystercard.touch_in
    expect{oystercard.touch_out}.to change {subject.balance}.by -1
  end

  it "expects the length to change by -1" do
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard.entry_station).to eq nil
end
end

end
