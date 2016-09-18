#!/usr/bin/env ruby -w

require 'rmagick'

input_name = ARGV[0]
output_name = (ARGV[1].nil? ? ARGV[0] : ARGV[1])

puts 'Input name: ' + input_name
puts 'Output name: ' + output_name

img = Magick::Image.read(input_name).first

width = img.columns
height = img.rows

width.times do |w|
  height.times do |h|
    actual_color = [] << img.pixel_color(w, h).to_color
    negative = (['black', 'white'] - actual_color).first

    if img.pixel_color(w-1, h-1).to_color == negative &&
       img.pixel_color(w-1, h).to_color == negative &&
       img.pixel_color(w-1, h+1).to_color == negative &&
       img.pixel_color(w, h-1).to_color == negative &&
       img.pixel_color(w, h+1).to_color == negative &&
       img.pixel_color(w+1, h-1).to_color == negative &&
       img.pixel_color(w+1, h).to_color == negative &&
       img.pixel_color(w+1, h+1).to_color == negative &&
      img.pixel_color(w,h, negative)
    end
  end
end

img.write(output_name)
