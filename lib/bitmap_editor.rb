class BitmapEditor
  require './lib/bitmap'

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    execute_commands(file)
  end

  def execute_commands(file)
    b = Bitmap.new(5, 6, "O")

    File.open(file).each do |line|
      line = line.gsub(/\s+/m, ' ').strip.split(" ")
      case line[0]
      when "I"
        b.create_bitmap
      when "L"
        b.draw_pixel(line[1], line[2], line[3])
      when "V"
        b.draw_vertical_segment(line[1], line[2], line[3], line[4])
      when "H"
        b.draw_horizontal_segment(line[1], line[2], line[3], line[4])
      when "C"
        b.clear_bitmap
      when "S"
        b.print_bitmap
      end
    end
  end

end
