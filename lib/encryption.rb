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

# Move to module?
  def a_shift
    sum_key_digits(0, 1)
    # create offset
    # collect offset digit
    # add offset key to key digit sum
  end

  def sum_key_digits(first_digit, second_digit)
    @key[first_digit].to_i + @key[second_digit].to_i
  end

  def create_offset
    (@date.to_i * @date.to_i).to_s[-4..-1]
  end
end
