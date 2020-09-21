require './test/test_helper'
require './lib/encryption'
require './lib/decryption'
require './lib/cracker'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_can_encrypt
    enigma = Enigma.new

    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, enigma.encrypt("hello world", "02715", "040895")
  end

  def test_it_can_decrypt
    enigma = Enigma.new

    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_can_crack
    enigma = Enigma.new

    expected = {
      decryption: "hello world end",
      date: "291018"
      # key
    }
    assert_equal expected, enigma.crack("vjqtbeaweqihssi", "291018")
  end
end
