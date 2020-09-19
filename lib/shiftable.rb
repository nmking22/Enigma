module Shiftable
  def a_shift
    @key[0..1].to_i + collect_offset_digit(0)
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

  def encrypt_message
    shift_counter = 1
    message_array = @message.split("")
    encrypted_message = message_array.map do |letter|
      if shift_counter % 4 == 1
        shift_counter += 1
        shift(letter, a_shift)
      elsif shift_counter % 4 == 2
        shift_counter += 1
        shift(letter, b_shift)
      elsif shift_counter % 4 == 3
        shift_counter += 1
        shift(letter, c_shift)
      elsif shift_counter % 4 == 0
        shift_counter += 1
        shift(letter, d_shift)
      end
    end
    encrypted_message.join
  end
end
