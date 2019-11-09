# class FileUploader < CarrierWave::Uploader::Base
#   include CarrierWave::Video
#   include CarrierWave::MiniMagick
#   include CarrierWave::Video::Thumbnailer
#   # include CarrierWaveDirect::Uploader
#   # include Delayed::Job
#   # include ::CarrierWave::Backgrounder::Delay
#
#
#   # process encode_video: [:mp4]
#
#   # def encode_video format
#   #   directory = File.dirname(current_path)
#   #   tmpfile = File.join(directory, 'tmpfile')
#   #   File.rename(current_path, tmpfile)
#
#   #   file = ::FFMPEG::Movie.new(tmpfile)
#   #   new_name = File.basename(current_path, '.*') + '.' + format.to_s
#   #   current_extenstion = File.extname(current_path).gsub('.', '')
#   #   encoded_file = File.join(directory, new_name)
#   #   file.transcode(encoded_file)
#
#   #   # warning: magic!
#   #   # change format for uploaded file name and store file format
#   #   # without this lines processed video files will remain in cache folder
#   #   self.filename[-current_extenstion.size..-1] = format.to_s
#   #   self.file.file[-current_extenstion.size..-1] = format.to_s
#
#   #   File.delete(tmpfile)
#   # end
#   version :thumb do
#     process thumbnail: [{format: 'jpg', quality: 7, size: 192, logger: Rails.logger}]
#
#     def full_filename for_file
#       png_name for_file, version_name
#     end
#   end
#
#   def png_name for_file, version_name
#     %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.jpg}
#   end
#
#   # def proceed file
#   #   proceed_after_upload(file)
#   # end
#   # after :store, :proceed
#
#
#   # Choose what kind of storage to use for this uploader:
#   # storage :file
#   storage :fog
#
#   # Override the directory where uploaded files will be stored.
#   # This is a sensible default for uploaders that are meant to be mounted:
#   def store_dir
#     "uploads/#{model.id}"
#   end
#
#   # Provide a default URL as a default if there hasn't been a file uploaded:
#   # def default_url
#   #   # For Rails 3.1+ asset pipeline compatibility:
#   #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
#   #
#   #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
#   # end
#
#   # Process files as they are uploaded:
#   # process scale: [200, 300]
#   #
#   # def scale(width, height)
#   #   # do something
#   # end
#
#   # Create different versions of your uploaded files:
#   # version :thumb do
#   #   process resize_to_fit: [200, 200]
#   # end
#
#   # Add a white list of extensions which are allowed to be uploaded.
#   # For images you might use something like this:
#   def extension_whitelist
#     %w(3gp avi flv mp4 mov wmv mpg ogg m4v webm mkv)
#     #%w(mp4 ogg webm)
#   end
#
#   # Override the filename of the uploaded files:
#   # Avoid using model.id or version_name here, see uploader/store.rb for details.
#   # def filename
#   #   rand(2000).to_s + original_filename if original_filename
#   # end
#
#   def move_to_store
#     true
#   end
#   def move_to_cache
#     true
#   end
#
# end
