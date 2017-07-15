class FileManager 
	require 'json'
	attr_accessor :init_colour, :init_bitmap, :colour_pixel, :draw_vertical_segment,
                  :draw_horizontal_segment, :show_command, :clear, :max_rows, :max_columns, :file

	def initialize(file)
		@file = file
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
end