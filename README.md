# Bitmap editor


Bitmap simulator, which reads the provided file, finds if there are any errors that prohibit execution of the commands and print them. 
If there are no errors in the file, commands are executed.

# Running

`>bin/bitmap_editor examples/show.txt`

# Ruby version

```sh
ruby '2.3.4'
```

# Gems used

```sh
gem 'rspec'
gem 'json'
```


# Install Gems
```sh
bundle install

# Run RSpec examples
```sh
bundle exec rspec
```
```

# Supported Commands

| Command | Parameters | Does |
| ------ | ------ | ------ |
| I | M N | Create a new M x N image with all pixels coloured white (O). |
| L | X Y C | Colours the pixel (X,Y) with colour C. |
| V | X Y1 Y2 W | Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive). |
| H | X1 X2 Y C | Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive). |
| C | - | Clears the table, setting all pixels to white (O). |
| S | - | Show the contents of the current image. |

### Extra Command

| Command | Parameters | Does |
| ------ | ------ | ------ |
| D | X1 Y1 X2 Y2 I | Draw a diagonal line of colour C, start from X1,Y1 and end at X2,Y2 |

Note:
If given pixels don't create a diagonal line it will prin error.


# Program input

The input consists of a file containing a sequence of commands. 
* A command is represented by a single capital letter at the beginning of the line. 
* Parameters of the command are separated by white spaces and they follow the command character.
* Pixel co-ordinates are a pair of integers: a column number between 1 and 250, and a row number between 1 and 250. 
* Bitmaps starts at coordinates 1,1. 
* Colours are specified by capital letters.

# Example
Input file:
```sh
I 5 6
L 1 3 A
V 2 3 6 W
H 3 5 2 Z
D 3 6 1 4 F
S
```

Output:
```sh
OOOOO
OOZZZ
AWOOO
FWOOO
OFOOO
OWFOO
```

