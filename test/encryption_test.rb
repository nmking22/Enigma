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
    assert_equal "0400", encryption.offset
  end

  def test_initialize_default_arguments
    Date.stubs(:today).returns(Date.new(2020,9,18))
    Kernel.stubs(:rand).with(99999).returns(1234)
    encryption = Encryption.new("Hello World")

    assert_equal "01234", encryption.key
    assert_equal "180920", encryption.date
  end

  def test_sum_key_digits
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal 3, encryption.sum_key_digits(0, 1)
    assert_equal 5, encryption.sum_key_digits(1, 2)
    assert_equal 7, encryption.sum_key_digits(2, 3)
    assert_equal 9, encryption.sum_key_digits(3, 4)
  end

  def test_create_offset
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal "0400", encryption.create_offset
  end

  def test_collect_offset_digit
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal 0, encryption.collect_offset_digit(0)
    assert_equal 4, encryption.collect_offset_digit(1)
    assert_equal 0, encryption.collect_offset_digit(2)
    assert_equal 0, encryption.collect_offset_digit(3)
  end

  def test_a_shift
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal 3, encryption.a_shift
  end

  def test_b_shift
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal 9, encryption.b_shift
  end

  def test_c_shift
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal 7, encryption.c_shift
  end

  def test_d_shift
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal 9, encryption.d_shift
  end

  def test_encrypt
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal "knsuricxuuk", encryption.encrypt
  end
end
