class Encryption
  attr_reader :message,
              :character_set

  def initialize(message, key = nil, date = Date.today)
    @message = message
    @key = key
    @date = date
    @character_set = ("a".."z").to_a << " "
  end

# Move to module?
  def key
    if @key == nil
      @key = Kernel.rand(99999).to_s.rjust(5, "0")
    end
    @key
  end

# Move to module?
  def date
    if @date.class == Date
      @date = @date.strftime("%d%m%y")
    end
    @date
  end
end
