class BitmapEditor
  require './lib/file_manager'
  require './lib/bitmap'

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    f = FileManager.new(file)
    f.read_file
    
    # Check the file, if there are any errors print them and exit, otherwise execute the commands.
    if f.errors_found_in_file.any?
      f.show_errors
      exit
    else
      execute_commands(file,f)
    end 

  end

  def execute_commands(file,f)
    b = Bitmap.new(f.given_cols_number, f.given_rows_number, f.init_colour)

    File.open(file).each do |line|
      line = line.gsub(/\s+/m, ' ').strip.split(" ")
      case line[0]
      when f.init_bitmap
        b.create_bitmap
      when f.colour_pixel
        b.draw_pixel(line[1], line[2], line[3])
      when f.draw_vertical_segment
        b.draw_vertical_segment(line[1], line[2], line[3], line[4])
      when f.draw_horizontal_segment
        b.draw_horizontal_segment(line[1], line[2], line[3], line[4])
      when f.clear
        b.clear_bitmap
      when f.show_command
        b.print_bitmap
      end
    end
  end

end
