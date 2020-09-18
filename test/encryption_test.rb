require 'minitest/autorun'
require 'minitest/pride'
require './lib/encryption'
require 'date'
require 'mocha/minitest'
require 'mocha/setup'

class EncryptionTest < Minitest::Test
  def test_it_exists
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_instance_of Encryption, encryption
  end

  def test_it_has_readable_attributes
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal "Hello World", encryption.message
    assert_equal "12345", encryption.key
    assert_equal "040520", encryption.date
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
      "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_equal expected, encryption.character_set
  end

  def test_initialize_default_arguments
    Date.stubs(:today).returns(Date.new(2020,9,18))
    Kernel.stubs(:rand).with(99999).returns(1234)
    encryption = Encryption.new("Hello World")

    assert_equal "01234", encryption.key
    assert_equal "180920", encryption.date
  end

  def test_a_shift
    skip
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal 5, encryption.a_shift
  end

  def test_sum_key_digits
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal 3, encryption.sum_key_digits(0, 1)
  end
end
