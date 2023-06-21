require "image_processing/mini_magick"

class ImageUploader < Shrine


	Attacher.derivatives do |original|
	    magick = ImageProcessing::MiniMagick.source(original).saver(quality: 88)
	    # generate the thumbnails you want here 
	    { 
	      thumb:  magick.resize_to_fill!(150, 150),
		  iso_optimized:  magick.resize_to_limit!(300, 800),
	      medium: magick.resize_to_fill!(500, 500),
	      large:  magick.resize_to_limit!(800, 800),
		  fancybox:  magick.resize_to_limit!(1400, 1400),
	    }
  	end
	
end