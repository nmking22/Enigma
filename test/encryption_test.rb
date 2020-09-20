require './test/test_helper'
require './lib/encryption'
require 'mocha/minitest'
require 'mocha/setup'

class EncryptionTest < Minitest::Test
  def test_it_exists
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_instance_of Encryption, encryption
  end

  def test_it_has_readable_attributes
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal "hello world", encryption.message
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

  def test_random_key_is_in_range
    encryption = Encryption.new("Hello World")

    assert_includes(0..99999, encryption.key.to_i)
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

    assert_equal 12, encryption.a_shift
  end

  def test_b_shift
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal 27, encryption.b_shift
  end

  def test_c_shift
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal 34, encryption.c_shift
  end

  def test_d_shift
    encryption = Encryption.new("Hello World", "12345", "040520")

    assert_equal 45, encryption.d_shift
  end

  def test_shift_message
    encryption = Encryption.new("Hello World", "08304", "291018")

    assert_equal "vjqtbeaweqi", encryption.shift_message(encryption.message)
  end

  def test_shift_into_character_set
    encryption = Encryption.new("Hello World", "08304", "291018")
    shift = 147

    assert_equal 12, encryption.shift_into_character_set(shift)
  end

  def test_encrypt
    encryption = Encryption.new("Hello World", "02715", "040895")

    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, encryption.encrypt
  end

  def test_shift
    encryption = Encryption.new("Hello World", "02715", "040895")

    assert_equal "k", encryption.shift("h", encryption.a_shift)
    assert_equal "e", encryption.shift("e", encryption.b_shift)
    assert_equal "d", encryption.shift("l", encryption.c_shift)
    assert_equal "e", encryption.shift("l", encryption.d_shift)
  end

  def test_shift_letter
    encryption = Encryption.new("Hello World", "02715", "040895")

    assert_equal "k", encryption.shift_letter("h", 0)
    assert_equal "e", encryption.shift_letter("e", 1)
    assert_equal "d", encryption.shift_letter("l", 2)
    assert_equal "e", encryption.shift_letter("l", 3)
  end
end
