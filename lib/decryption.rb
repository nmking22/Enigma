require './lib/shiftable'
require './lib/decryptable'

class Decryption
  include Shiftable
  include Decryptable
  attr_reader :ciphertext,
              :key,
              :offset,
              :character_set
  def initialize(ciphertext, key, date = Date.today)
    @ciphertext = ciphertext
    @key = key
    @date = date
    @offset = create_offset
    @character_set = ("a".."z").to_a << " "
  end

  def decrypt
    encrypted_info = {
      :decryption => shift_message(@ciphertext),
      :key => key,
      :date => date
    }
  end
end
