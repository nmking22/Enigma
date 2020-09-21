require './lib/shiftable'
require './lib/decryptable'

class Cracker
  include Shiftable
  include Decryptable
  attr_reader :ciphertext,
              :offset,
              :character_set,
              :last_four_characters,
              :ending_indexes,
              :shifts
  def initialize(ciphertext, date = Date.today)
    @ciphertext = ciphertext
    @date = date
    @offset = create_offset
    @character_set = ("a".."z").to_a << " "
    @last_four_characters = ciphertext[-4..-1].split("")
    @ending_indexes = [26, 4, 13, 3]
    @shifts = []
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

  def populate_shifts
    shifts_array = []
    @last_four_characters.each_with_index do |letter, index|
      shift_amount = (@character_set.index(letter) - ending_indexes[index])
      if shift_amount < 0
        shift_amount += 27
      end
      shifts_array << shift_amount
    end
    @shifts = rotate_shifts(shifts_array)
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

  def a_shift
    @shifts[0]
  end

  def b_shift
    @shifts[1]
  end

  def c_shift
    @shifts[2]
  end

  def d_shift
    @shifts[3]
  end

  def crack
    populate_shifts
    encrypted_info = {
      :decryption => shift_message(@ciphertext),
      :date => date,
      # :key => key
    }
  end
end
