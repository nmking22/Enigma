require 'minitest/autorun'
require 'minitest/pride'
require './lib/decryption'
require 'date'
require 'mocha/minitest'
require 'mocha/setup'

class DecryptionTest < Minitest::Test
  def test_it_exists
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_instance_of Decryption, decryption
  end

  def test_it_has_readable_attributes
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_equal "keder ohulw", decryption.ciphertext
    assert_equal "02715", decryption.key
    assert_equal "040895", decryption.date
  end
end
