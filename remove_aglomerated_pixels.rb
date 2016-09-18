#!/usr/bin/env ruby -w

require 'rmagick'
require 'to_binary_matrix.rb'

inner_radius = ARGV[0].to_i

input_name = ARGV[1]
output_name = (ARGV[2].nil? ? ARGV[1] : ARGV[2])

border_size = 1
outer_radius = border_size + set_radius


img = Magick::Image.read('./Imagens/2.png').first

matrix = to_binary_matrix(img)

width = img.columns
height = img.rows

(height - 2*outer_radius).times do |h|
  (width - 2*outer_radius).times do |w|
    j = w + outer_radius
    i = h + outer_radius

    is_set = true
    border_color = matrix[i + outer_radius][j + outer_radius]


    outer_radius.times do |s|
      step = s + 1

      if is_set == true
        if matrix[i + outer_radius][j + outer_radius - step] != border_color ||
           matrix[i - outer_radius][j + outer_radius - step] != border_color ||
           matrix[i + outer_radius - step][j + outer_radius] != border_color ||
           matrix[i + outer_radius - step][j + outer_radius] != border_color
          is_set = false
        end
      end
    end

    if is_set
      matrix[j][i] = border_color

      inner_radius.times do |l|
        (2*inner_radius).times do |p|
          layer = l + 1
          pixel = p + 1

          matrix[i + layer - pixel][j + layer] = border_color
          matrix[i - layer][j + layer - pixel] = border_color
          matrix[i - layer + pixel][j - layer] = border_color
          matrix[i + layer][j - layer + pixel] = border_color
        end
      end
    end
  end
end

#some code using matrix to fill the image with black or white

img.write()
