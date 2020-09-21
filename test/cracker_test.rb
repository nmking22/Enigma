require './test/test_helper'
require './lib/cracker'
require 'mocha/minitest'
require 'mocha/setup'

class CrackerTest < Minitest::Test
  def test_it_exists
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    assert_instance_of Cracker, cracker
  end

  def test_it_has_readable_attributes
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
      "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal "vjqtbeaweqihssi", cracker.ciphertext
    assert_equal "291018", cracker.date
    assert_equal expected, cracker.character_set
    assert_equal "6324", cracker.offset
    assert_equal ["h", "s", "s", "i"], cracker.last_four_characters
    assert_equal [26, 4, 13, 3], cracker.ending_indexes
    assert_equal [], cracker.shifts
  end

  def test_date_defaults_to_today
    Date.stubs(:today).returns(Date.new(2020,9,18))
    cracker = Cracker.new("vjqtbeaweqihssi")

    assert_equal "180920", cracker.date
  end

  def test_shifted_offset
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")
    cracker_2 = Cracker.new("jqtbeaweqihssi", "291018")
    cracker_3 = Cracker.new("qtbeaweqihssi", "291018")
    cracker_4 = Cracker.new("tbeaweqihssi", "291018")

    assert_equal "3246", cracker.shifted_offset
    assert_equal "2463", cracker_2.shifted_offset
    assert_equal "4632", cracker_3.shifted_offset
    assert_equal "6324", cracker_4.shifted_offset
  end

  def test_rotate_offset
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    assert_equal "3246", cracker.rotate_offset(1)
    assert_equal "2463", cracker.rotate_offset(2)
    assert_equal "4632", cracker.rotate_offset(3)
  end

  def test_populate_shifts
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    assert_equal [14, 5, 5, 8], cracker.populate_shifts
  end

  def test_rotate_shifts
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")
    cracker_2 = Cracker.new("vjqtbeaweqihss", "291018")
    cracker_3 = Cracker.new("vjqtbeaweqihs", "291018")
    cracker_4 = Cracker.new("vjqtbeaweqih", "291018")

    assert_equal [14, 5, 5, 8], cracker.rotate_shifts([8, 14, 5, 5])
    assert_equal [5, 5, 8, 14], cracker_2.rotate_shifts([8, 14, 5, 5])
    assert_equal [5, 8, 14, 5], cracker_3.rotate_shifts([8, 14, 5, 5])
    assert_equal [8, 14, 5, 5], cracker_4.rotate_shifts([8, 14, 5, 5])
  end

  def test_a_shift
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    assert_equal 14, cracker.a_shift
  end

  def test_b_shift
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    assert_equal 5, cracker.b_shift
  end

  def test_c_shift
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    assert_equal 5, cracker.c_shift
  end

  def test_d_shift
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    assert_equal 8, cracker.d_shift
  end
end
