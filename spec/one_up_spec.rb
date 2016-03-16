require 'spec_helper'

describe OneUp do
  context 'has a version number' do
    Then { OneUp::VERSION != nil }
  end

  context "integration tests" do
    context "dsl syntax" do
      Given(:giver) {}
      Given(:gift) {}
      Given(:receiver) {}
      When { giver.give(gift, to: receiver) }
    end
  end
end
