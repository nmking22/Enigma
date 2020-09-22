# README

## Self-Evaluation

### Functionality

4 - I implemented all of the functionality of the project. My encrypt/decrypt/cracking methods are all completely functional, and the CLIs run as specified in the spec.

### Object Oriented Programming

3.5 or 4 - I think all of my classes have specific purposes and only carry out those purposes. I implemented two module files - shiftable and decryptable - that pass methods to classes that can shift and decrypt respectably. Both of these are used appropriately and help DRY up the code. My cracker class may be too long, though. I think given more time, I would have extracted a key_cracker class out of this to shorten the file. I do think all of the functionality through iteration 3, however, adheres to OOP.

### Ruby Conventions and Mechanics

3 - My code is properly indented with consistent syntax. I think many of my enumerables and data structures are the most efficient tools for the job, but probably not all of them. I do have a few methods that are just over 10 lines of code (11) that I couldn't figure out how to trim down in a logical way. My naming is logical and descriptive of what everything does, but some of my names may be a bit too similar, and could cause confusion.

### Test Driven Development

3.5 - I wrote all of my tests before creating the associated methods. SimpleCov passes at 100% and everything is tested. I do think that I could have used mocks and stubs more. I used them to test randomness for random keys and to test default date arguments, but not for anything else.

### Version Control

4 - Almost 200 commits with descriptive commit messages that each tackle one piece of functionality.
11 pull requests that each pertain to logical chunks and include descriptive comments about what was changed, and often, what needs to be changed/improved.
