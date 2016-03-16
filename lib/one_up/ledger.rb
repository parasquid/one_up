module OneUp
  class Ledger
    def initialize(repository: default_repository)
      @repository = repository
    end

    def add_entry(giver:, receiver:, gift:, created_at: Time.now)
      @repository << {
        giver: giver,
        receiver: receiver,
        gift: gift,
        created_at: created_at
      }
    end

    def entries
      @repository
    end

    private

    def default_repository
      []
    end
  end
end