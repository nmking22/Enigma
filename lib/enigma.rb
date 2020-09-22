require './lib/encryption'
require './lib/decryption'
require './lib/cracker'

class Enigma
  def initialize

  end

  def encrypt(message, key = nil, date = Date.today.strftime("%d%m%y"))
    encryption = Encryption.new(message, key, date)
    encryption.encrypt
  end

  def decrypt(ciphertext, key = nil, date = Date.today.strftime("%d%m%y"))
    decryption = Decryption.new(ciphertext, key, date)
    decryption.decrypt
  end

  def crack(ciphertext, date = Date.today.strftime("%d%m%y"))
    cracker = Cracker.new(ciphertext, date)
    cracker.crack
  end
end
