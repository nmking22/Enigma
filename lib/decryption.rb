require './lib/shiftable'

class Decryption
  include Shiftable
  attr_reader :ciphertext,
              :key,
              :date
  def initialize(ciphertext, key, date)
    @ciphertext = ciphertext
    @key = key
    @date = date
  end
end
