require "spec_helper"
require "./lib/bitmap.rb"

describe Bitmap do 
	before do 
		@bitmap = Bitmap.new(5,6,"O") # Command 'I' params '5 6' , init colour 'O'
	end

	it "initializes the required params for the bitmap. Rows, cols numbers and init colour" do 
		expect(@bitmap.rows_number).to eq(5)
		expect(@bitmap.cols_number).to eq(6)
		expect(@bitmap.init_colour).to eq('O')
	end

	it "creates the tables 5 x 6 filled with 'O's" do 
		@bitmap.create_bitmap # Command 'I'
		expect(@bitmap.bitmap).to eq(Array.new(6) { Array.new(5) { "O" }})
	end

	it "draws the pixel 1,3 with colour 'A'" do 
		@bitmap.create_bitmap
		@bitmap.draw_pixel(1,3,"A") # Command 'L' params '1 3 A'
		expect(@bitmap.bitmap[2][0]).to eq("A")
	end

	it "draws a vertical segment at column 2 and rows from 3 to 6, with colour 'W'" do 
		@bitmap.create_bitmap
		@bitmap.draw_vertical_segment(2,3,6,"W") # Command 'V' params '2 3 6 W'
		expect(@bitmap.bitmap[2][1]).to eq("W")
		expect(@bitmap.bitmap[3][1]).to eq("W")
		expect(@bitmap.bitmap[4][1]).to eq("W")
		expect(@bitmap.bitmap[5][1]).to eq("W")
	end

	it "draws a horizontal segment at row 2 and columns from 3 to 5 with colour 'Z'" do 
		@bitmap.create_bitmap
		@bitmap.draw_horizontal_segment(3,5,2,"Z") # Command 'H' params '3 5 2 Z'
		expect(@bitmap.bitmap[1][2]).to eq("Z")
		expect(@bitmap.bitmap[1][3]).to eq("Z")
		expect(@bitmap.bitmap[1][4]).to eq("Z")
	end

	it "clears the bitmap from added colours" do 
		@bitmap.create_bitmap
		@bitmap.draw_pixel(1,3,"A")
		@bitmap.draw_vertical_segment(2,3,6,"W")
		@bitmap.draw_horizontal_segment(3,5,2,"Z")
		@bitmap.clear_bitmap # Commmand 'C'
		expect(@bitmap.bitmap).to eq(Array.new(6) { Array.new(5) { "O" }})
	end

	it "prints the bitmap 5 x 6 filled with 'O's " do 
		@bitmap.create_bitmap
		expected_bitmap_format = "OOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\nOOOOO\n"
		expect { @bitmap.print_bitmap }.to output(expected_bitmap_format).to_stdout
	end

	it "executes all the commands and prints the coloured bitmap" do 
		@bitmap.create_bitmap # Command 'I'
		@bitmap.draw_pixel(1,3,"A") # Command 'L' params '1 3 A'
		@bitmap.draw_vertical_segment(2,3,6,"W") # Command 'V' params '2 3 6 W'
		@bitmap.draw_horizontal_segment(3,5,2,"Z") # Command 'H' params '3 5 2 Z'
		expected_bitmap_format = "OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO\n"
	    expect { @bitmap.print_bitmap }.to output(expected_bitmap_format).to_stdout
	end
	
	it "draws a diagonal segment from left/top to right/bottom" do 
		@bitmap.create_bitmap
		@bitmap.draw_diagonal_segment(1,2,5,6,'I')
		expected_bitmap_format = "OOOOO\nIOOOO\nOIOOO\nOOIOO\nOOOIO\nOOOOI\n"
	    expect { @bitmap.print_bitmap }.to output(expected_bitmap_format).to_stdout
	end

	it "draws a diagonal segment from right/bottom to left/top" do 
		@bitmap.create_bitmap
		@bitmap.draw_diagonal_segment(5,6,1,2,'I')
		expected_bitmap_format = "OOOOO\nIOOOO\nOIOOO\nOOIOO\nOOOIO\nOOOOI\n"
	    expect { @bitmap.print_bitmap }.to output(expected_bitmap_format).to_stdout
	end

	it "draws a diagonal segment from left/bottom to right/top" do 
		@bitmap.create_bitmap
		@bitmap.draw_diagonal_segment(1,6,5,2,'I')
		expected_bitmap_format = "OOOOO\nOOOOI\nOOOIO\nOOIOO\nOIOOO\nIOOOO\n"
	    expect { @bitmap.print_bitmap }.to output(expected_bitmap_format).to_stdout
	end

	it "draws a diagonal segment from right/top to left/bottom" do 
		@bitmap.create_bitmap
		@bitmap.draw_diagonal_segment(5,2,1,6,'I')
		expected_bitmap_format = "OOOOO\nOOOOI\nOOOIO\nOOIOO\nOIOOO\nIOOOO\n"
	    expect { @bitmap.print_bitmap }.to output(expected_bitmap_format).to_stdout
	end

end