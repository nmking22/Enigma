class Enigma
  def initialize

  end

  def encrypt(message, key = nil, date = Date.today)
    encryption = Encryption.new(message, key, date)
    encryption.encrypt
  end
end
