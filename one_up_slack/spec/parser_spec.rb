require "spec_helper"
require "parser"

describe Parser do
  Given(:text) { "@username message :1up:"}
  Given(:parser) { Parser.new(text) }
  When(:result) { parser.parse }
  Then { result.receiver == "@username" }
  Then { result.message == "message" }
  Then { result.gift == ":1up:" }

  context "extract the @username" do
    Given(:text) { "@parasquid message :1up:"}
    When(:result) { parser.parse }
    Then { result.receiver == "@parasquid" }
  end

  context "extract the emojii" do
    Given(:text) { "@parasquid message :1up: ignored"}
    When(:result) { parser.parse }
    Then { result.gift == ":1up:" }
  end

  context "extract the message" do
    Given(:text) { "@parasquid this is a multi word message :1up: ignored"}
    When(:result) { parser.parse }
    Then { result.message == "this is a multi word message" }
  end

  context "edge cases" do
    context "no gift" do
      Given(:text) { "@username there is no gift"}
      When(:result) { parser.parse }
      Then { result.gift == nil }
    end
  end
end