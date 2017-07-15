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

	it "adds error if params size for init command is not correct", :skip_before do 
		@f= FileManager.new("./spec/spec_examples/wrong_size_of_params.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("Wrong number of parameteres.")
	end

	it "adds error if param is out of min - max range", :skip_before do 
		@f= FileManager.new("./spec/spec_examples/param_out_of_range.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("Param is not in the correct range of numbers")
	end

	it "adds error if pixel param is not integer", :skip_before do 
		@f= FileManager.new("./spec/spec_examples/pixel_param_is_not_integer.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("Params for bitmap pixels must be integers.")
	end

	it "adds error if colour param is not from 'A' to 'Z'", :skip_before do 
		@f= FileManager.new("./spec/spec_examples/colour_param_is_not_valid.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("Param for colour must be a Capital letter (A .. Z).")
	end

	it "adds error if vertical segment command has wrong params", :skip_before do 
		@f= FileManager.new("./spec/spec_examples/vertical_cmd_wrong_params.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("Wrong number of parameteres.")
	end

	it "adds error if vertical segment command has wrong colour params", :skip_before do 
		@f= FileManager.new("./spec/spec_examples/horizontal_cmd_wrong_colour_param.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("Param for colour must be a Capital letter (A .. Z).")
	end

	it "adds errors that command clear and show has wrong params", :skip_before do 
		@f= FileManager.new("./spec/spec_examples/clear_show_cmds_wrong_param.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("Wrong number of parameteres.")
		expect(@f.errors_found_in_file[0]).to eq("Wrong number of parameteres.")
	end

end