class Parser
  def initialize(text)
    @text = text
  end
  def parse
    result = Struct.new(:receiver, :message, :gift)
    result.new(receiver, message, gift)
  end

  private

  USERNAME_REGEX = /\@\S+/
  EMOJI_REGEX = /\:\S+\:/
  EVERYTHING_ELSE_IN_BETWEEN_REGEX = /.+/
  SUPER_REGEX = /(#{USERNAME_REGEX})(#{EVERYTHING_ELSE_IN_BETWEEN_REGEX})(#{EMOJI_REGEX})/

  def super_regex_match(position)
    matches = SUPER_REGEX.match(@text)
    !!matches ? matches[position].strip : nil
  end

  def receiver
    super_regex_match(1)
  end

  def message
    super_regex_match(2)
  end

  def gift
    super_regex_match(3)
  end

end