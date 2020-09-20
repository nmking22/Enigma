require './lib/shiftable'

class Cracker
  include Shiftable
  attr_reader :ciphertext,
              :offset,
              :character_set,
              :last_four_characters
  def initialize(ciphertext, date = Date.today)
    @ciphertext = ciphertext
    @date = date
    @offset = create_offset
    @character_set = ("a".."z").to_a << " "
    @last_four_characters = ciphertext[-4..-1]
  end

  def shifted_offset
    if @ciphertext.length % 4 == 1
      rotate(3)
    elsif @ciphertext.length % 4 == 2
      rotate(2)
    elsif @ciphertext.length % 4 == 3
      rotate(1)
    elsif @ciphertext.length % 4 == 0
      @offset
    end
  end

  def rotate(number)
    new_offset = @offset.split("")
    new_offset.rotate(number).join
  end
  # find shifted offset to be used on last four chars
  # check length of ciphertext % 4
    # if 1 -> rotate 3
    # if 2 -> rotate 2
    # if 3 -> rotate 1
    # if 4 -> return offset
    # ROTATION PROCESS:
      # convert offset to array
      # use array.rotate(num)
      # convert offset back to string

  # pull out last four characters of string
  # ending final indexes: 26, 4, 13, 3
  # ending test indexes: 7, 18, 18, 8
  # shifts: 8, 14, 5, 5

end
