module OneUp
  class User
    attr_accessor :name
    def initialize(name:, ledger:)
      @name = name
      @ledger = ledger
    end

    def give(gift, to:, message:)
      @ledger.add_entry(giver: self, receiver: to, gift: gift, message: message)
    end
  end
end