require './lib/shiftable'

class Encryption
  include Shiftable
  attr_reader :message,
              :character_set,
              :offset

  def initialize(message, key = nil, date = Date.today)
    @message = message.downcase
    @key = key
    @date = date
    @character_set = ("a".."z").to_a << " "
    @offset = create_offset
  end

  def key
    if @key == nil
      @key = Kernel.rand(99999).to_s.rjust(5, "0")
    end
    @key
  end

  def date
    if @date.class == Date
      @date = @date.strftime("%d%m%y")
    end
    @date
  end

  def encrypt
    encrypted_info = {
      :encryption => encrypt_message,
      :key => key,
      :date => date
    }
  end
end
