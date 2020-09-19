require './lib/shiftable'

class Decryption
  include Shiftable
  attr_reader :ciphertext,
              :key,
              :offset
  def initialize(ciphertext, key, date = Date.today)
    @ciphertext = ciphertext
    @key = key
    @date = date
    @offset = create_offset
  end
end
