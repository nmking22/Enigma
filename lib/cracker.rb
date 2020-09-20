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
end
