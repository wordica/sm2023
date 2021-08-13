require "image_processing/mini_magick"

class ImageUploader < Shrine


	Attacher.derivatives do |original|
	    magick = ImageProcessing::MiniMagick.source(original).saver(quality: 88)
	    # generate the thumbnails you want here 
	    { 
	      thumb:  magick.resize_to_fill!(150, 150),
	      medium: magick.resize_to_fill!(500, 500),
	      large:  magick.resize_to_limit!(800, 800),
	    }
  	end
	
end