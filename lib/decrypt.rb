require './lib/enigma'
require './lib/decryption'
require 'date'

file = File.open(ARGV[0], "r")

message = file.read.delete("\n")

enigma = Enigma.new
decryption = enigma.decrypt(message, ARGV[2], ARGV[3])
decryption_file = File.open(ARGV[1], "w")
decryption_file.write(decryption[:decryption])
puts "Created '#{ARGV[1]}' with the key #{decryption[:key]} and date #{decryption[:date]}"
