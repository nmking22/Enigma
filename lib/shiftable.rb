module Shiftable
  def date
    if @date.class == Date
      @date = @date.strftime("%d%m%y")
    end
    @date
  end

  def a_shift
    key[0..1].to_i + collect_offset_digit(0)
  end

  def b_shift
    @key[1..2].to_i + collect_offset_digit(1)
  end

  def c_shift
    @key[2..3].to_i + collect_offset_digit(2)
  end

  def d_shift
    @key[3..4].to_i + collect_offset_digit(3)
  end

  def create_offset
    (date.to_i * date.to_i).to_s[-4..-1]
  end

  def collect_offset_digit(index)
    @offset[index].to_i
  end

  def shift_message(message)
    message_array = message.split("")
    encrypted_message = message_array.each_with_index.map do |letter, index|
      shift_letter(letter, index)
    end
    encrypted_message.join
  end

  def shift_letter(letter, index)
    if index % 4 == 0
      shift(letter, a_shift)
    elsif index % 4 == 1
      shift(letter, b_shift)
    elsif index % 4 == 2
      shift(letter, c_shift)
    elsif index % 4 == 3
      shift(letter, d_shift)
    end
  end
end
