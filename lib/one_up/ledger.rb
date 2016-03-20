module OneUp
  class Ledger
    def initialize(repository: default_repository)
      @repository = repository
    end

    def add_entry(giver:, receiver:, gift:, message:, created_at: Time.now)
      @repository << {
        giver: giver,
        receiver: receiver,
        gift: gift,
        message: message,
        created_at: created_at
      }
    end

    def entries
      @repository
    end

    def entries_today
      today_start = Date.today.to_time
      today_end = (Date.today + 1).to_time - 1
      @repository.select { |e| (today_start..today_end).cover? e[:created_at] }
    end

    private

    def default_repository
      []
    end
  end
end