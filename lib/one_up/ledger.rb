module OneUp
  require "one_up/mixins/acts_as_crud"
  class LedgerRepository
    extend Mixins::ActsAsCrud
    attr_accessor :giver, :receiver, :gift, :message, :created_at
    def initialize(giver:, receiver:, gift:, message:, created_at: Time.now)
      @giver = giver
      @receiver = receiver
      @gift = gift
      @message = message
      @created_at = created_at
    end
  end

  class Ledger
    def initialize(repository: LedgerRepository)
      @repository = repository
    end

    def add_entry(giver:, receiver:, gift:, message:, created_at: Time.now)
      @repository.create(
        giver: giver,
        receiver: receiver,
        gift: gift,
        message: message,
        created_at: created_at
      )
    end

    def entries
      @repository.all
    end

    def entries_today
      today_start = Date.today.to_time
      today_end = (Date.today + 1).to_time - 1
      @repository.all.select { |e| (today_start..today_end).cover? e.created_at }
    end

    def clear_repository
      @repository.delete_all
    end
  end
end