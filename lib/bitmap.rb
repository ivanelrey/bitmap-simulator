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
		@bitmap[y.to_i-1][x.to_i-1] = colour
	end

	def draw_vertical_segment(column, start_row_pixel, end_row_pixel, colour)
		if end_row_pixel < start_row_pixel
	      start_row_pixel,end_row_pixel = end_row_pixel,start_row_pixel
	    end
	    for row_pixel in (start_row_pixel..end_row_pixel)
	      draw_pixel(column,row_pixel,colour)
	    end
	end

	def draw_horizontal_segment(start_col_pixel, end_col_pixel, row, colour)
	   	if end_col_pixel < start_col_pixel
	      start_col_pixel,end_col_pixel = end_col_pixel,start_col_pixel
	    end
	    for col_pixel in (start_col_pixel..end_col_pixel)
	      draw_pixel(col_pixel,row,colour)
	    end
	end

	def clear_bitmap
		create_bitmap # Reinitilialize the bitmap
	end

	def print_bitmap
    	@bitmap.each do |row|
	      row.each do |cell|
	        print cell 
	      end
	      puts
	    end
  	end
  	
end