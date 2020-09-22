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
              :shifts,
              :key
  def initialize(ciphertext, date = Date.today)
    @ciphertext = ciphertext
    @date = date
    @offset = create_offset
    @character_set = ("a".."z").to_a << " "
    @last_four_characters = ciphertext[-4..-1].split("")
    @ending_indexes = [26, 4, 13, 3]
    @shifts = []
    @key = key
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
    find_key
    encrypted_info = {
      :decryption => shift_message(@ciphertext),
      :date => date,
      :key => @key
    }
  end

  def key_shifts
    key_shifts = populate_shifts.each_with_index.map do |shift, index|
      key_shift = shift - offset[index].to_i
      if key_shift < 0
        key_shift + 27
      else
        key_shift
      end
    end
  end

  def find_key
    loop do
      possibility = possible_key_shift
      if valid_possibility?(possibility)
        @key = possibility[0] + possibility[1][1] + possibility[2][1] + possibility[3][1]
        break
      end
    end
    @key
  end

  def valid_possibility?(possibility)
    possibility[0][1] == possibility[1][0] &&
    possibility[1][1] == possibility[2][0] &&
    possibility [2][1] == possibility[3][0]
  end

  def key_shift_possibilities
    shift_possibilities = Hash.new { |h, k| h[k] = [] }
    key_shifts.each_with_index do |shift, index|
      until shift > 99
        shift_possibilities[index] << shift.to_s.rjust(2, "0")
        shift += 27
      end
    end
    shift_possibilities
  end

  def possible_key_shift
    possible_key_shift = key_shift_possibilities.map do |key, possibilities|
      possibilities.sample
    end
    possible_key_shift
  end
end
