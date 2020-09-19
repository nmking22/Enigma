require './lib/shiftable'

class Decryption
  include Shiftable
  attr_reader :ciphertext,
              :key, # is this needed?
              :offset,
              :character_set
  def initialize(ciphertext, key, date = Date.today)
    @ciphertext = ciphertext
    @key = key
    @date = date
    @offset = create_offset
    @character_set = ("a".."z").to_a << " "
  end

  def shift(letter, shift_type)
    new_index = @character_set.index(letter) - shift_type
    @character_set[shift_into_character_set(new_index)]
  end

  def shift_into_character_set(index)
    loop do
      if index < 0
        index += 27
      else
        break
      end
    end
    index
  end
end
