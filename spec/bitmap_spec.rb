require "spec_helper"
require "./lib/bitmap.rb"

describe Bitmap do 

	it "initializes the required params for the bitmap. Rows, cols numbers and init colour" do 
		bitmap = Bitmap.new(5,6,"O") # Command 'I' params '5 6' , init colour 'O'
		expect(bitmap.rows_number).to eq(5)
		expect(bitmap.cols_number).to eq(6)
		expect(bitmap.init_colour).to eq('O')
	end

	it "creates the tables 5 x 6 filled with 'O's" do 
		bitmap = Bitmap.new(5,6,"O")
		bitmap.create_bitmap # Command 'I'
		expect(bitmap.bitmap).to eq(Array.new(6) { Array.new(5) { "O" }})
	end

	it "draws the pixel 1,3 with colour 'A'" do 
		bitmap = Bitmap.new(5,6,"O")
		bitmap.create_bitmap
		bitmap.draw_pixel(1,3,"A") # Command 'L' params '1 3 A'
		expect(bitmap.bitmap[0][2]).to eq("A")
	end

end