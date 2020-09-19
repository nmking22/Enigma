class Enigma
  def initialize

  end

  def encrypt(message, key = nil, date = Date.today)
    encryption = Encryption.new(message, key, date)
    encryption.encrypt
  end

  def decrypt(message, key = nil, date = Date.today)
    decryption = Decryption.new(message, key, date)
    decryption.decrypt
  end
end
