require 'minitest/autorun'
require 'minitest/pride'
require './lib/encryption'
require 'date'
require 'mocha/minitest'

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
  end

  def test_initialize_default_arguments
    Date.stubs(:today).returns(Date.new(2020,9,18))
    encryption = Encryption.new("Hello World")

    assert_equal "Hello World", encryption.message
    assert_equal "12345", encryption.key
    assert_equal "180920", encryption.date
  end
end
