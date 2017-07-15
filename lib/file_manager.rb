class FileManager 
	require 'json'
	attr_accessor :init_colour, :init_bitmap, :colour_pixel, :draw_vertical_segment,
                  :draw_horizontal_segment, :show_command, :clear, :max_rows, :max_columns, :file,
                  :errors_found_in_file

	def initialize(file)
		@file = file
		@errors_found_in_file = Array.new
		init_settings
	end

	def init_settings
	    file = File.read ("./lib/settings.json")
	    if file.nil?
	      puts "Please provide correct settings.json file."
	    end
	    data = JSON.parse(file)
	    @init_bitmap = data["init_bitmap"]
	    @clear = data["clear"]
	    @colour_pixel = data["colour_pixel"]
	    @draw_vertical_segment = data["draw_vertical_segment"]
	    @draw_horizontal_segment = data["draw_horizontal_segment"]
	    @show_command = data["show_command"]
	    @init_colour = data["init_colour"]
	    @max_columns = data["max_columns"]
    	@max_rows = data["max_rows"]
  	end

  	def read_file
  		File.open(@file, "r").each_with_index do |line, line_number|
	      line_number = line_number + 1
	      line = line.gsub(/\s+/m, ' ').strip.split(" ")
	      if line_number == 1 and line[0] != @init_bitmap # if the first commans is not "I"
	      	@errors_found_in_file << "First command must be 'I' to initialize the bitmap."
	      	return
	      end
	      check_line(line, line_number)
	  	end
  	end

  	def check_line(line,line_number)
		case line[0]
		when @init_bitmap
			#check for the init command
		when @colour_pixel
	  		#check for the draw pixel command
		when @draw_vertical_segment
	  		#check for the draw vertical segment command
		when @draw_horizontal_segment
	  		#check for the draw vertical segment command
		when @clear
	  		#check for the clear command
		when @show_command
			#check for the show command
		else
		  	if (line[0] != line[0].upcase)
				@errors_found_in_file << "Commands must be only capital letters."
			else
		    	@errors_found_in_file << "Unrecognised command :(."
		  	end
		end		
	end

end