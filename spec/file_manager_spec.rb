require 'spec_helper'
require './lib/file_manager.rb'

describe FileManager do |example|

	before do 
		unless RSpec.current_example.metadata[:skip_before]
			@f= FileManager.new("./examples/show.txt")
		end
	end

	it "initializes init variables" do 
		expect(@f.file).to eq("./examples/show.txt")
		expect(@f.init_colour).to eq("O")
		expect(@f.init_bitmap).to eq("I")
		expect(@f.clear).to eq("C")
		expect(@f.colour_pixel).to eq("L")
		expect(@f.draw_vertical_segment).to eq("V")
		expect(@f.draw_horizontal_segment).to eq("H")
		expect(@f.show_command).to eq("S")
		expect(@f.max_rows).to eq(250)
		expect(@f.max_columns).to eq(250)
	end

	it "stops reading the file because the first command is not 'I'(to initialize the bitmap)", :skip_before do 
		@f= FileManager.new("./spec/spec_examples/the_first_cmd_not_init.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("First command must be 'I' to initialize the bitmap.")
	end

	it "adds error if lower case command found", :skip_before do 
		@f= FileManager.new("./spec/spec_examples/contains_lower_case_cmd.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("Commands must be only capital letters.")
	end

	it "adds error if unrecognized command found", :skip_before do 
		@f= FileManager.new("./spec/spec_examples/contains_unknown_cmd.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("Unrecognised command :(.")
	end
	
end