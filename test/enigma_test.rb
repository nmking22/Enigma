require 'minitest/autorun'
require 'minitest/pride'
require './lib/encryption'
require 'date'
require 'mocha/minitest'
require 'mocha/setup'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end
end
