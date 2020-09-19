class Encryption
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
# Move to module?
  def a_shift
    @key[0..1].to_i + collect_offset_digit(0)
  end
  # Move to module?
  def b_shift
    @key[1..2].to_i + collect_offset_digit(1)
  end
  # Move to module?
  def c_shift
    @key[2..3].to_i + collect_offset_digit(2)
  end
  # Move to module?
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
        new_index = @character_set.index(letter) + a_shift
        @character_set[shift_into_character_set(new_index)]
      elsif shift_counter % 4 == 2
        shift_counter += 1
        new_index = @character_set.index(letter) + b_shift
        @character_set[shift_into_character_set(new_index)]
      elsif shift_counter % 4 == 3
        shift_counter += 1
        new_index = @character_set.index(letter) + c_shift
        @character_set[shift_into_character_set(new_index)]
      elsif shift_counter % 4 == 0
        shift_counter += 1
        new_index = @character_set.index(letter) + d_shift
        @character_set[shift_into_character_set(new_index)]
      end
    end
    encrypted_message.join
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
end

def encrypt
  encrypted_info = {
    :encryption => encrypt_message,
    :key => key,
    :date => date
  }
end
