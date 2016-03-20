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
    When { ledger.clear_repository; ledger.add_entry(entry) }
    Then { ledger.entries.first.giver == giver }
    Then { ledger.entries.first.receiver == receiver }
    Then { ledger.entries.first.gift == gift }
    Then { ledger.entries.first.message == message }
  end

  context "stores the time of record creation" do
    Given(:created_at) { Time.at 0 }
    When { ledger.clear_repository; ledger.add_entry(entry.merge(created_at: created_at)) }
    Then { ledger.entries.first.created_at = created_at }
  end

  context "can list all entries" do
    When { ledger.clear_repository; 3.times {ledger.add_entry(entry)} }
    Then { ledger.entries.count == 3 }
  end

  context "can list all entries that were given today" do
    Given(:today_date) { Date.today }
    Given(:today) { today_date.to_time }
    Given(:yesterday) { (today_date - 1).to_time }
    Given(:tomorrow) { (today_date + 1).to_time }
    context "two entries today" do
      Given {
        ledger.clear_repository
        ledger.add_entry(entry.merge(created_at: yesterday))
        2.times { ledger.add_entry(entry.merge(created_at: today)) }
        ledger.add_entry(entry.merge(created_at: tomorrow))
      }
      When(:result) { ledger.entries_today }
      Then { result.count == 2 }
    end
    context "three entries today" do
      Given {
        ledger.clear_repository
        ledger.add_entry(entry.merge(created_at: yesterday))
        3.times { ledger.add_entry(entry.merge(created_at: today)) }
        ledger.add_entry(entry.merge(created_at: tomorrow))
      }
      When(:result) { ledger.entries_today }
      Then { result.count == 3 }
    end
  end
end