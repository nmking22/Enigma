require './lib/shiftable'

class Cracker
  include Shiftable
  attr_reader :ciphertext,
              :offset,
              :character_set,
              :last_four_characters,
              :ending_indexes
  def initialize(ciphertext, date = Date.today)
    @ciphertext = ciphertext
    @date = date
    @offset = create_offset
    @character_set = ("a".."z").to_a << " "
    @last_four_characters = ciphertext[-4..-1].split("")
    @ending_indexes = [26, 4, 14, 3]
  end

  def shifted_offset
    if @ciphertext.length % 4 == 1
      rotate(3)
    elsif @ciphertext.length % 4 == 2
      rotate(2)
    elsif @ciphertext.length % 4 == 3
      rotate(1)
    elsif @ciphertext.length % 4 == 0
      @offset
    end
  end

  def rotate(number)
    new_offset = @offset.split("")
    new_offset.rotate(number).join
  end

  def find_shifts
    # helper method to array and rotate offsets
    # iterate through last_four_characters
    # require 'pry'; binding.pry
    shifts_array = []
    @last_four_characters.each_with_index do |letter, index|
      shifts_array << (@character_set.index(letter) - ending_indexes[index])
    end
    shifts_array
  end
  # pull out last four characters of string
  # ending final indexes: 26, 4, 13, 3
  # ending test indexes: 7, 18, 18, 8
  # shifts: 8, 14, 5, 5
  # char_index - ending_index = shift
end
