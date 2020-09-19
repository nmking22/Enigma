require './lib/shiftable'

class Decryption
  include Shiftable
  attr_reader :ciphertext,
              :key
  def initialize(ciphertext, key, date = Date.today)
    @ciphertext = ciphertext
    @key = key
    @date = date
  end
end
