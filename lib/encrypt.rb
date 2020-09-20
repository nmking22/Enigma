require './lib/enigma'
require './lib/encryption'
require 'date'

file = File.open(ARGV[0], "r")

message = file.read.delete("\n")

enigma = Enigma.new
encryption = enigma.encrypt(message)
encryption_file = File.open(ARGV[1], "w")
encryption_file.write(encryption[:encryption])
puts "Created 'encrypted.txt' with the key #{encryption[:key]} and date #{encryption[:date]}"
