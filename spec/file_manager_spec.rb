require 'spec_helper'
require './lib/file_manager.rb'

describe FileManager do |example|

	after do
		unless RSpec.current_example.metadata[:skip_before]		
 			File.delete("./spec/test.txt")		
 		end
  	end

	it "initializes init variables", :skip_before do 
		@f= FileManager.new("./examples/show.txt")
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

	it "stops reading the file because the first command is not 'I'(to initialize the bitmap)" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("L 3 5")
		out_file.puts("I 5 6")
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("First command must be 'I' to initialize the bitmap.")
	end

	it "adds error if lower case command found" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5 6")
		out_file.puts("l 1 3 A")
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("ERROR in line 2: A command must be a capital letter.")
	end

	it "adds error if unrecognized command found" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5 6")
		out_file.puts("K 1 3 A")
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("ERROR in line 2: Unrecognised command :(.")
	end

	it "adds error if params size for init command is not correct" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5")
		out_file.puts("L 1 3 A")
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("ERROR in line 1: Number of parameteres for this command is 2 ")
	end

	it "adds error if param is out of min - max range" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5 300")
		out_file.puts("L 1 3 A")
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("ERROR in line 1: Wrong param '300'. The current param must be in range (1 .. 250)")
	end

	it "adds error if pixel param is not integer" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5 S")
		out_file.puts("L 1 3 A")
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("ERROR in line 1: Wrong param 'S'.The current param must be an integer. ")
	end

	it "adds error if colour param is not from 'A' to 'Z'" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5 6")
		out_file.puts("L 1 3 ss")
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("ERROR in line 2: Wrong param 'ss'.Param must be a Capital letter (A .. Z).")
	end

	it "adds error if vertical segment command has wrong params" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5 6")
		out_file.puts("L 1 3 A")
		out_file.puts("V 1 3 A")
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("ERROR in line 3: Number of parameteres for this command is 4 ")
	end

	it "adds error if horizontal segment command has wrong colour params" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5 6")
		out_file.puts("L 1 3 A")
		out_file.puts("V 2 3 6 W")
		out_file.puts("H 3 5 2 5")
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("ERROR in line 4: Wrong param '5'.Param must be a Capital letter (A .. Z).")
	end

	it "adds errors that command clear and show has wrong params" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5 6")
		out_file.puts("L 1 3 A")
		out_file.puts("V 2 3 6 W")
		out_file.puts("H 3 5 2 F")
		out_file.puts("C 4")
		out_file.puts("S 2")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("ERROR in line 5: Number of parameteres for this command is 0 ")
		expect(@f.errors_found_in_file[1]).to eq("ERROR in line 6: Number of parameteres for this command is 0 ")
	end

	it "should not have any errors" do
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5 6")
		out_file.puts("L 1 3 A")
		out_file.puts("V 2 3 6 W")
		out_file.puts("H 3 5 2 Z")
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file).to be_empty
	end

	it "deletes empty lines from the file" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("    \n")
		out_file.puts("\n")
		out_file.puts("I 5 6")
		out_file.puts("\n")
		out_file.puts("    \n")
		out_file.puts("    \n")
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.remove_blank_lines_from_file
		count = IO.readlines(@f.file).size  
		expect(count).to eq(2) 
	end

	it "prints the errors" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5 6")
		out_file.puts("L 1 3 A")
		out_file.puts("V 2 3 6 W")
		out_file.puts("H 3 5 2 F")
		out_file.puts("C 4")
		out_file.puts("S 2")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expected_errors = "ERROR in line 5: Number of parameteres for this command is 0 \nERROR in line 6: Number of parameteres for this command is 0 \n"
		expect { @f.show_errors }.to output(expected_errors).to_stdout
	end

	it "adds error that given pixels don't create diagonal line" do 
		out_file = File.new("./spec/test.txt", "w+")
		out_file.puts("I 5 6")
		out_file.puts("D 1 3 3 4 I") # 1,3 and 3,4 are not the samxe 'diagonal' line
		out_file.puts("S")
		out_file.close
		@f= FileManager.new("./spec/test.txt")
		@f.read_file
		expect(@f.errors_found_in_file[0]).to eq("ERROR in line 2: The given pixels are not on the same diagonal line.")

	end

end