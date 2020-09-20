require './lib/shiftable'

class Cracker
  include Shiftable
  attr_reader :ciphertext,
              :character_set
  def initialize(ciphertext, date = Date.today)
    @ciphertext = ciphertext
    @date = date
    @character_set = ("a".."z").to_a << " "
  end
end
