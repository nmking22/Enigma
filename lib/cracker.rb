require './lib/shiftable'

class Cracker
  include Shiftable
  attr_reader :ciphertext,
              :offset,
              :character_set
  def initialize(ciphertext, date = Date.today)
    @ciphertext = ciphertext
    @date = date
    @offset = create_offset
    @character_set = ("a".."z").to_a << " "
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
  # ending indexes: 26, 4, 13, 3

end
