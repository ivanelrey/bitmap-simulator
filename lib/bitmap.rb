class Bitmap
	attr_accessor :rows_number, :cols_number, :init_colour, :bitmap

	def initialize(rows_number,cols_number,init_colour)
		@rows_number = rows_number
		@cols_number = cols_number
		@init_colour = init_colour
	end

	def create_bitmap
		@bitmap = Array.new(@cols_number.to_i){Array.new(@rows_number.to_i){ @init_colour } }
	end

	def draw_pixel(x,y,colour)
		@bitmap[x.to_i-1][y.to_i-1] = colour
	end
end