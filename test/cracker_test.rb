require './test/test_helper'
require './lib/cracker'
# Remove mocha requires if mocks/stubs not used
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
  end

  def test_date_defaults_to_today
    Date.stubs(:today).returns(Date.new(2020,9,18))
    cracker = Cracker.new("vjqtbeaweqihssi")

    assert_equal "180920", cracker.date
  end

  def test_find_shifted_offset
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")
    cracker_2 = Cracker.new("jqtbeaweqihssi", "291018")
    cracker_3 = Cracker.new("qtbeaweqihssi", "291018")
    cracker_4 = Cracker.new("tbeaweqihssi", "291018")

    assert_equal "4632", cracker.find_shifted_offset
    assert_equal "2463", cracker_2.find_shifted_offset
    assert_equal "4632", cracker_3.find_shifted_offset
    assert_equal "6342", cracker_4.find_shifted_offset
  end

  def test_rotate
    cracker = Cracker.new("vjqtbeaweqihssi", "291018")

    assert_equal "4632", cracker.rotate(1)
    assert_equal "2463", cracker.rotate(2)
    assert_equal "4632", cracker.rotate(3)
  end
end
