require "spec_helper"
require "one_up/ledger"

describe OneUp::Ledger do
  Given(:ledger) { OneUp::Ledger.new }
  Given(:giver) { double("Giver") }
  Given(:receiver) { double("Receiver") }
  Given(:gift) { double("Gift") }
  Given(:message) { "this is the message" }
  Given(:entry) {
   { giver: giver, receiver: receiver, gift: gift, message: message }
  }

  context "can add an entry" do
    When { ledger.add_entry(entry) }
    Then { expect(ledger.entries.first).to include(entry) }
  end

  context "stores the time of record creation" do
    Given(:created_at) { Time.at 0 }
    When { ledger.add_entry(entry.merge(created_at: created_at)) }
    Then { expect(ledger.entries.first).to include(created_at: created_at) }
  end

  context "can list all entries" do
    When { 3.times {ledger.add_entry(entry)} }
    Then { ledger.entries.count == 3 }
  end

  context "can list all entries that were given today" do
    Given(:today_date) { Date.today }
    Given(:today) { Time.at(today_date.to_time.to_i) }
    Given(:yesterday) { Time.at((today_date - 1).to_time.to_i) }
    Given(:tomorrow) { Time.at((today_date + 1).to_time.to_i) }
    context "two entries today" do
      Given {
        ledger.add_entry(entry.merge(created_at: yesterday))
        ledger.add_entry(entry.merge(created_at: today))
        ledger.add_entry(entry.merge(created_at: today))
        ledger.add_entry(entry.merge(created_at: tomorrow))
      }
      When(:result) { ledger.entries_today }
      Then { result == 2 }
    end
  end
end