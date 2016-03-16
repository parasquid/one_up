require "spec_helper"
require "one_up/ledger"

describe OneUp::Ledger do
  Given(:ledger) { OneUp::Ledger.new }
  Given(:giver) { double("Giver") }
  Given(:receiver) { double("Receiver") }
  Given(:gift) { double("Gift") }

  context "can add an entry" do
    When { ledger.add_entry(giver: giver, receiver: receiver, gift: gift) }
    Then { expect(ledger.entries.first)
            .to include({giver: giver, receiver: receiver, gift: gift})
    }
  end

  context "stores the time of record creation" do
    Given(:created_at) { Time.at 0 }
    When { ledger.add_entry(
            giver: giver,
            receiver: receiver,
            gift: gift,
            created_at: created_at)
    }
    Then { expect(ledger.entries.first)
            .to include(
              giver: giver,
              receiver: receiver,
              gift: gift,
              created_at: created_at)
    }
  end

  context "can list all entries" do
    When { 3.times {ledger.add_entry(giver: giver, receiver: receiver, gift: gift)} }
    Then { ledger.entries.count == 3 }
  end
end