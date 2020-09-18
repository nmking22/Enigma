require 'minitest/autorun'
require 'minitest/pride'
require './lib/encryption'

class EncryptionTest < Minitest::Test
  def test_it_exists
    encryption = Encryption.new("Hello World", "12345", "050420")

    assert_instance_of Encryption, encryption
  end

  def test_it_has_readable_attributes
    encryption = Encryption.new("Hello World", "12345", "050420")

    assert_equal "Hello World", encryption.message
    assert_equal "12345", encryption.key
    assert_equal "050420", encryption.date
  end
end
