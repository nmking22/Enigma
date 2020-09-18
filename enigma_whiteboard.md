## Enigma Whiteboarding

***Algorithm only encrypts lowercase alphabet & space***

Create character set with

`("a".."z").to_a << " "`

### Shifts

***4 Shifts***

Every four letters uses the same shift (A, B, C, D)

Each shift pushes letter by the sum of **the keys** and **the offsets** for it's corresponding shift

***The Keys***

The keys use a randomly generated five digit number. Each key is the sum of two of those digits:
1. A - pos 1, 2
1. B - pos 2, 3
1. C - pos 3, 4
1. D - pos 4, 5

***The Offsets***

The offsets are extrapolated from the date form DDMMYY

1. DDMMYY is squared
1. Last four digits are pulled out
1. Each offset is one of the digits

### Encryption

***Create Shifts***

1. Generate random 5 digit number for key - could use (00000..99999).sample perhaps? - look into how to pad leading zeroes
1. Convert date to DDMMYY format
1. Square date
1. Add digits for each shift - probably should have a separate shift method for each shift that is called on later

***Encryption Steps***

1. Downcase string
1. Iterate through string |letter|
1. Use conditional logic to tell each letter which shift to use - first thought here is to use the times method `(string.length).times` and use the optional block variable to direct this flow
1. Call corresponding shift for each letter
1. Must account for characters not in our character set - ***Does this skip a shift or not? Ask instructors***

***Shift mechanics***

1. Probably similar to caesar cipher - put character set into a hash with numerical values as keys
1. Iterate through our string |letter| - probably want to use a map method here? Could also create and empty array with each if map doesn't work
1. Use hash method to find the key of the letter that we are shifting
1. Add shift to the key
1. Need conditional statement here - if key does not exist, then subtract 27 from key - loop this?
1. Pull value from the new shifted key
1. Shovel value into array
1. After iteration, use join method to turn our array into a string

### Decryption

For decryption, we have key and date data, and must shift a string backwards. This should be a very similar process to encryption with a few variations

***Process***
1. Shifts are created the same, except that we do not generate a key - instead we use the argument key - this means key creation ***must*** be in a helper method
1. Encryption steps are identical
1. Shift mechanics are similar, though we **subtract** the shift from our hash keys instead of adding them
1. Additionally, our conditional must **add** 27 if the hash key does not exist instead of subtracting 27

### Cracking a Key

Key is not known, but we have the date and encryption. We also know that the last four characters of the encryption decode to " end".

1. Extract the shift offsets from date
1. Iterate through the last four characters of the encrypted string - can use [-4..-1]?
1. Shift key should be equal to the hash key of the encrypted letter minus the offset minus the hash key of the known letter

## Responsibilities

1. Traffic Cop - Enigma
1. Encryption
1. Decryption
1. Cracking
1. Key/Offset Creation
1. Shift Creation

## Class Structure

1. Enigma Class - takes no arguments - contains encrypt, decrypt, crack methods -> these methods should pass to other classes
1. Encryption Class - gets created in Enigma.encrypt - gets passed three arguments: message string, key, date
1. Decryption Class - gets created in Enigma.decrypt - gets passed three arguments: ciphertext, key, date
1. Crack Class - gets created in Enigma.crack - gets passed two arguments: ciphertext, date
1. Key/Offset/Shift Creation - these three may get bundled into above methods, or may make more sense as extracted classes - ***OR Modules??***
