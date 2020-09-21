require './lib/enigma'
require './lib/cracker'
require 'date'

file = File.open(ARGV[0], "r")

message = file.read.delete("\n")

enigma = Enigma.new
cracker = enigma.crack(message, ARGV[2])
cracked_file = File.open(ARGV[1], "w")
cracked_file.write(cracker[:decryption])
puts "Created '#{ARGV[1]}' with the cracked key #{cracker[:key]} and date #{cracker[:date]}"
