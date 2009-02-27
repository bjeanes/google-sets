# Google Sets

This is a very small library that provides a wrapper for [Google Sets](http://labs.google.com/sets).

I plan to make a command line tool very soon (need to sleep now!) to get sets and choose a random item from a set from the console.

For now here is some usage examples:

    set = GoogleSet.new('titania', 'oberon', 'romeo')
    
    puts set   ### Outputs:
               # romeo
               # oberon
               # daphne
               # delfinen
               # zwaardvis
               # agosta
               # dolfijn
               # narvahlen
               # kilo
               # upholder
      
    set.rand   # => agosta
    set[8]     # => kilo
    set.size   # => 10
    set.to_a   # => ["romeo", "oberon", "daphne", "delfinen", "zwaardvis", 
               #     "agosta", "dolfijn", "narvahlen", "kilo", "upholder"]