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
    assert_equal nil, cracker.key
  end

  def test_date_defaults_to_today
    Date.stubs(:today).returns(Date.new(2020,9,18))
    cracker = Cracker.new("vjqtbeaweqihssi")

    assert_equal "180920", cracker.date
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
    cracker.populate_shifts

    assert_equal 14, cracker.a_shift
  end

  def test_b_shift
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")
    cracker.populate_shifts

    assert_equal 5, cracker.b_shift
  end

  def test_c_shift
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")
    cracker.populate_shifts

    assert_equal 5, cracker.c_shift
  end

  def test_d_shift
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")
    cracker.populate_shifts

    assert_equal 8, cracker.d_shift
  end

  def test_crack
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    expected = {
      decryption: "hello world end",
      date: "291018",
      key: "08304"
    }

    assert_equal expected, cracker.crack
  end

  def test_shift
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    cracker.populate_shifts

    assert_equal "h", cracker.shift("v", cracker.a_shift)
    assert_equal "e", cracker.shift("j", cracker.b_shift)
    assert_equal "l", cracker.shift("q", cracker.c_shift)
    assert_equal "l", cracker.shift("t", cracker.d_shift)
  end

  def test_non_character_set_characters_are_not_shifted
    cracker = Cracker.new("v3q7be>w?qihssi", "291018")

    cracker.populate_shifts

    assert_equal "h3l7o >o?ld end", cracker.crack[:decryption]
  end

  def test_shift_into_character_set
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    index = -141

    assert_equal 21, cracker.shift_into_character_set(index)
  end

  def test_shift_message
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    cracker.populate_shifts

    assert_equal "hello world end",
    cracker.shift_message(cracker.ciphertext)
  end

  def test_shift_letter
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    cracker.populate_shifts

    assert_equal "h", cracker.shift_letter("v", 0)
    assert_equal "e", cracker.shift_letter("j", 1)
    assert_equal "l", cracker.shift_letter("q", 2)
    assert_equal "l", cracker.shift_letter("t", 3)
  end

  def test_key_shifts
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    cracker.populate_shifts

    assert_equal [8, 2, 3, 4], cracker.key_shifts
  end

  def test_key_shifts_returns_positive_values
    cracker = Cracker.new("vjqtbeaweqihssi", "291019")

    cracker.populate_shifts

    assert_equal [6, 2, 26, 7], cracker.key_shifts
  end

  def test_find_key
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    cracker.populate_shifts

    assert_equal "08304", cracker.find_key
  end

  def test_key_shift_possibilities
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    cracker.populate_shifts

    expected = {
      0 => ["08", "35", "62", "89"],
      1 => ["02", "29", "56", "83"],
      2 => ["03", "30", "57", "84"],
      3 => ["04", "31", "58", "85"]
    }

    assert_equal expected, cracker.key_shift_possibilities
  end

  def test_possible_key_shift
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    cracker.populate_shifts

    assert_equal 4, cracker.possible_key_shift.length
    assert_includes(["08", "35", "62", "89"], cracker.possible_key_shift[0])
    assert_includes(["02", "29", "56", "83"], cracker.possible_key_shift[1])
    assert_includes(["03", "30", "57", "84"], cracker.possible_key_shift[2])
    assert_includes(["04", "31", "58", "85"], cracker.possible_key_shift[3])
  end
end
