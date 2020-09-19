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
end
