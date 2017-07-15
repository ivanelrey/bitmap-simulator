require 'spec_helper'
require './lib/file_manager.rb'

describe FileManager do 

	before do 
		@f= FileManager.new("./lib/show.txt")
	end

	it "initializes init variables" do 
		expect(@f.file).to eq("./lib/show.txt")
		expect(@f.init_colour).to eq("O")
		expect(@f.clear).to eq("C")
		expect(@f.colour_pixel).to eq("L")
		expect(@f.draw_vertical_segment).to eq("V")
		expect(@f.draw_horizontal_segment).to eq("H")
		expect(@f.show_command).to eq("S")
		expect(@f.max_rows).to eq(250)
		expect(@f.max_columns).to eq(250)
	end

end