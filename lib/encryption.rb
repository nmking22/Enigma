require './lib/shiftable'

class Encryption
  include Shiftable
  attr_reader :message,
              :character_set,
              :offset,
              :date
  def initialize(message, key = nil, date = Date.today.strftime("%d%m%y"))
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

  def shift(letter, shift_type)
    if @character_set.include? letter
      new_index = @character_set.index(letter) + shift_type
      @character_set[shift_into_character_set(new_index)]
    else
      letter
    end
  end

  def shift_into_character_set(index)
    loop do
      if index > 26
        index -= 27
      else
        break
      end
    end
    index
  end

  def encrypt
    encrypted_info = {
      :encryption => shift_message(@message),
      :key => key,
      :date => date
    }
  end
end
