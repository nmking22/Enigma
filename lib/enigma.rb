class Enigma
  def initialize

  end

  def encrypt(message, key = nil, date = Date.today)
    encryption = Encryption.new(message, key, date)
    encryption.encrypt
  end

  def decrypt(ciphertext, key = nil, date = Date.today)
    decryption = Decryption.new(ciphertext, key, date)
    decryption.decrypt
  end

  def crack(ciphertext, date = Date.today)
    cracker = Cracker.new(ciphertext, date)
    cracker.crack
  end
end
