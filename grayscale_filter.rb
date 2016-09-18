#!/usr/bin/env ruby -w

require 'rmagick'

# filter_parameter may vary from 0 to 255
filter_parameter = ARGV[0].to_i
input_name = ARGV[1]
output_name = (ARGV[2].nil? ? ARGV[1] : ARGV[2])

puts 'Input name: ' + input_name
puts 'Output name: ' + output_name

puts "\n"

puts 'Filtering pixels above ' + filter_parameter + '...'

img = Magick::Image.read(input_name).first

width = img.columns
height = img.rows

width.times do |w|
  height.times do |h|
    if img.pixel_color(w,h).to_hsla[2] < filter_parameter
      img.pixel_color(w,h, 'black')
    else
      img.pixel_color(w,h, 'white')
    end
  end
end

img.write(output_name)
