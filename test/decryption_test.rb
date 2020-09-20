require './test/test_helper'
require './lib/decryption'
require 'mocha/minitest'
require 'mocha/setup'

class DecryptionTest < Minitest::Test
  def test_it_exists
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_instance_of Decryption, decryption
  end

  def test_it_has_readable_attributes
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
      "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal "keder ohulw", decryption.ciphertext
    assert_equal "02715", decryption.key
    assert_equal "040895", decryption.date
    assert_equal "1025", decryption.offset
    assert_equal expected, decryption.character_set
  end

  def test_date_defaults_to_today
    Date.stubs(:today).returns(Date.new(2020,9,18))
    decryption = Decryption.new("keder ohulw", "02715")

    assert_equal "180920", decryption.date
  end

  def test_create_offset
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_equal "1025", decryption.create_offset
  end

  def test_collect_offset_digit
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_equal 1, decryption.collect_offset_digit(0)
    assert_equal 0, decryption.collect_offset_digit(1)
    assert_equal 2, decryption.collect_offset_digit(2)
    assert_equal 5, decryption.collect_offset_digit(3)
  end

  def test_a_shift
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_equal 3, decryption.a_shift
  end

  def test_b_shift
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_equal 27, decryption.b_shift
  end

  def test_c_shift
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_equal 73, decryption.c_shift
  end

  def test_d_shift
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_equal 20, decryption.d_shift
  end

  def test_shift_message
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_equal "hello world",
    decryption.shift_message(decryption.ciphertext)
  end

  def test_shift_into_character_set
    decryption = Decryption.new("keder ohulw", "02715", "040895")
    index = -141

    assert_equal 21, decryption.shift_into_character_set(index)
  end

  def test_shift
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_equal "h", decryption.shift("k", decryption.a_shift)
    assert_equal "e", decryption.shift("e", decryption.b_shift)
    assert_equal "l", decryption.shift("d", decryption.c_shift)
    assert_equal "l", decryption.shift("e", decryption.d_shift)
  end

  def test_shift_letter
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    assert_equal "h", decryption.shift_letter("k", 0)
    assert_equal "e", decryption.shift_letter("e", 1)
    assert_equal "l", decryption.shift_letter("d", 2)
    assert_equal "l", decryption.shift_letter("e", 3)
  end

  def test_decrypt
    decryption = Decryption.new("keder ohulw", "02715", "040895")

    expected ={
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }
    assert_equal expected, decryption.decrypt
  end

  def test_non_character_set_characters_are_not_shifted
    decryption = Decryption.new("k3d7r >h?lw", "02715", "040895")

    assert_equal "h3l7o >o?ld", decryption.decrypt[:decryption]
  end
end
