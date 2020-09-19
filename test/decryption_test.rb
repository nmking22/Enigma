require 'minitest/autorun'
require 'minitest/pride'
require './lib/decryption'
require 'date'
require 'mocha/minitest'
require 'mocha/setup'

class DecryptionTest < Minitest::Test
  def test_it_exists
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_equal Decryption, decryption
  end
end
