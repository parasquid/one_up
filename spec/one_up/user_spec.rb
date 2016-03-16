require "spec_helper"
require "one_up/ledger"
require "one_up/user"

describe OneUp::User do
  Given(:user_name) { "test_name" }
  Given(:ledger) { OneUp::Ledger.new }
  Given(:giver) { OneUp::User.new(name: user_name, ledger: ledger) }

  context "can have attributes" do
    When(:result) { giver.name }
    Then { result == user_name }
  end

  context "giving gifts" do
    Given(:gift) { double("Gift") }
    Given(:receiver) { double("Receiver") }
    context "user can give a gift" do
      When { giver.give(gift, to: receiver) }
      Then { ledger.entries.count == 1 }
    end
  end
end