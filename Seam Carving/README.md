# Seam Carving
Seam Carving for intelligent resizing of images

#Synopsis

Seam Carving is a method of re-sizing an image which is in a sense context aware

The main idea of re-sizing is to identify a seam connecting from top to bottom (vertical seam) and/or left to right (horizontal seam) pixels with minimum energy.The energy can be defined in terms of gradient function 

For algorthimic details refer Reference section

#References
1. [Seam Carving for Content Aware Image Resizing SIGGRAPH 2007.](http://www.cse.iitd.ernet.in/~pkalra/csl783/assignment3/seamcarving.pdf)

2. [Wikipedia](http://en.wikipedia.org/wiki/Seam_carving)

#Input / Output

Run it in matlab by giving command of seamcarving('input_file',height_size,width_size)

Sample input file is provided

# Contributors

[Sai Vignan](http://www.iitd.ac.in/~cs5120289)

# License

Copyright (C) 2014  Sai Vignan K

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
