require 'matrix'

def to_binary_matrix image
  pixels_matrix = Matrix.build(image.rows, image.columns)

  img.each_pixel do |pixel, c, r|
    if img.pixel_color(c, r).to_color == 'black'
      pixels_matrix[r][c] = 1
    else
      pixels_matrix[r][c] = 0
    end
  end

  return pixels_matrix
end
