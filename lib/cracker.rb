class Cracker
  attr_reader :ciphertext,
              :date,
              :character_set
  def initialize(ciphertext, date)
    @ciphertext = ciphertext
    @date = date
    @character_set = ("a".."z").to_a << " "
  end
end
