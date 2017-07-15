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
			check_init_command(line, line_number)
		when @colour_pixel
	  		check_colour_pixel_command(line, line_number)
		when @draw_vertical_segment
	  		check_draw_vertical_segment_command(line, line_number)
		when @draw_horizontal_segment
	  		check_draw_horizontal_segment_command(line, line_number)
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

	def check_init_command(line, line_number)
	    if line_number != 1
	      @errors_found_in_file << "You can initialize the bitmap only in the first line."
	      return
	    end
		if check_params_size(line.size - 1, 2, line_number) #line.size = command + params
  			check_param_is_int_and_in_range(1, @max_columns, line_number, line[1])
      		check_param_is_int_and_in_range(1, @max_rows, line_number, line[2])
      		@given_rows_number = line[2].to_i
		    @given_cols_number = line[1].to_i
		    @bitmap_initialized = true
    	end
	end

	def check_colour_pixel_command(line, line_number)
	    if check_params_size(line.size - 1, 3, line_number) and @bitmap_initialized 
	      check_param_is_int_and_in_range(1, @given_cols_number, line_number, line[1])
	      check_param_is_int_and_in_range(1, @given_rows_number, line_number, line[2])
	      check_colour_param_is_capital_letter(line[3], line_number)
	    end
  	end

  	def check_draw_vertical_segment_command(line, line_number)
	    if check_params_size(line.size - 1, 4, line_number) and @bitmap_initialized
	      check_param_is_int_and_in_range(1, @given_cols_number, line_number, line[1])
	      check_param_is_int_and_in_range(1, @given_rows_number, line_number, line[2])
	      check_param_is_int_and_in_range(1, @given_rows_number, line_number, line[3])
	      check_colour_param_is_capital_letter(line[4], line_number)
	    end
  	end

  	def check_draw_horizontal_segment_command(line, line_number)
	    if check_params_size(line.size - 1, 4, line_number) and @bitmap_initialized
	      check_param_is_int_and_in_range(1, @given_cols_number, line_number, line[1])
	      check_param_is_int_and_in_range(1, @given_cols_number, line_number, line[2])
	      check_param_is_int_and_in_range(1, @given_rows_number, line_number, line[3])
	      check_colour_param_is_capital_letter(line[4], line_number)
	    end
  	end

	def check_params_size(params_size, valid_params_size, line_number)
		if params_size != valid_params_size
			@errors_found_in_file << "Wrong number of parameteres."
      		false
    	else
      		true
		end
	end

	def check_param_is_int_and_in_range(min_number, max_number, line_number, param)
	    if param_is_integer?(param)
	      if !param.to_i.between?(min_number, max_number)
	        @errors_found_in_file << "Param is not in the correct range of numbers"
	      end
	    else
	      @errors_found_in_file << "Params for bitmap pixels must be integers."
	    end
  	end

  	def check_colour_param_is_capital_letter(colour_param, line_number)
    	if !(colour_param.length == 1 && colour_param.between?("A", "Z"))
      		@errors_found_in_file << "Param for colour must be a Capital letter (A .. Z)."
    	end
  	end

  	def param_is_integer?(param)
    	!!(param !~ /\D/) 
  	end

end