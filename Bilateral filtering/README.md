# Bilateral Filtering
Filtering technique for better edge preservation

#Synopsis

Bilateral filtering is a technique for better edge preservation and noise-reducing smoothening

Main difference between other non-linear filters is that it samples not only using euclidean distances but also the intensity values around a pixel. 

See original and result files in folder to get overview of what its doing. Observe sharp edges have been preserved and noise is smoothened.

#References
1. [Wikipedia](https://en.wikipedia.org/wiki/Bilateral_filter)

2. A Gentle Introduction to Bilateral Filtering and its Applications - [Link](http://people.csail.mit.edu/sparis/bf_course/)

#Input / Output

Run it in matlab by giving command of bilateral('input_file',grid-size,space parameter,range parameter)

Sample input file is provided

# Contributors

[Sai Vignan](http://www.iitd.ac.in/~cs5120289)

# License

Copyright (C) 2014  Sai Vignan K

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
