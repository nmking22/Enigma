module Decryptable
  def shift(letter, shift_type)
    if @character_set.include? letter
      new_index = @character_set.index(letter) - shift_type
      @character_set[shift_into_character_set(new_index)]
    else
      letter
    end
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
