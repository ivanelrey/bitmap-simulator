class FileManager 
	attr_accessor :init_colour, :init_bitmap, :colour_pixel, :draw_vertical_segment,
                  :draw_horizontal_segment, :show_command, :clear, :max_rows, :max_columns, :file

	def initialize(file)
		@file = file
		@init_bitmap = Settings.fetch("init_bitmap")
	    @clear = Settings.fetch("clear")
	    @colour_pixel = Settings.fetch("colour_pixel")
	    @draw_vertical_segment = Settings.fetch("draw_vertical_segment")
	    @draw_horizontal_segment = Settings.fetch("draw_horizontal_segment")
	    @show_command = Settings.fetch("show_command")
	    @init_colour = Settings.fetch("init_colour")
	    @max_columns = Settings.fetch("max_columns")
	    @max_rows = Settings.fetch("max_rows")
	end

	Settings = {
	  "init_bitmap" => "I",
	  "clear" => "C",
	  "colour_pixel" => "L",
	  "draw_vertical_segment" => "V",
	  "draw_horizontal_segment" => "H",
	  "show_command" => "S",
	  "init_colour" => "O",
	  "max_rows" => 250,
	  "max_columns" => 250
	}.freeze
end