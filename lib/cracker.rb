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
    @ending_indexes = [26, 4, 13, 3]
  end

  def shifted_offset
    if @ciphertext.length % 4 == 1
      rotate_offset(3)
    elsif @ciphertext.length % 4 == 2
      rotate_offset(2)
    elsif @ciphertext.length % 4 == 3
      rotate_offset(1)
    elsif @ciphertext.length % 4 == 0
      @offset
    end
  end

  def rotate_offset(number)
    new_offset = @offset.split("")
    new_offset.rotate(number).join
  end

  def find_shifts
    # helper method to array and rotate offsets
    # iterate through last_four_characters
    shifts_array = []
    @last_four_characters.each_with_index do |letter, index|
      shift_amount = (@character_set.index(letter) - ending_indexes[index])
      if shift_amount < 0
        shift_amount += 27
      end
      shifts_array << shift_amount
    end
    rotate_shifts(shifts_array)
    # rotate
  end

  def rotate_shifts(shifts_array)
    if @ciphertext.length % 4 == 1
      shifts_array.rotate(3)
    elsif @ciphertext.length % 4 == 2
      shifts_array.rotate(2)
    elsif @ciphertext.length % 4 == 3
      shifts_array.rotate(1)
    elsif @ciphertext.length % 4 == 0
      shifts_array
    end
  end
  # pull out last four characters of string
  # ending final indexes: 26, 4, 13, 3
  # ending test indexes: 18, 18, 8, 7
  # shifts: 8, 14, 5, 4
  # char_index - ending_index = shift
end
