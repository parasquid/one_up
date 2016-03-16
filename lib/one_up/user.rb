module OneUp
  class User
    attr_accessor :name
    def initialize(name:, ledger:)
      @name = name
      @ledger = ledger
    end

    def give(gift, to:)
      @ledger.add_entry(giver: self, receiver: to, gift: gift)
    end
  end
end