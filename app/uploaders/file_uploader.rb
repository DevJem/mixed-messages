class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::Video
  # include CarrierWave::MiniMagick
  FFMPEG.ffmpeg_binary = '/usr/bin/ffmpeg'

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # process encode_video: [:mp4]

  # process encode_video: [
  #   watermark: {
  #     path: File.join(Rails.root, "public/", "favicon.ico"),
  #     position: :bottom_left,
  #     pixels_from_edge: 10
  #   }
  # ]
  # def filename
  #   result = [original_filename.gsub(/.\w+$/, ""), 'mp4'].join('.') if original_filename
  #   result
  # end

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    #%w(3gp avi flv mp4 mov wmv mpg ogg m4v webm)
    %w(mp4 ogg webm)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   rand(2000).to_s + original_filename if original_filename 
  # end

  def move_to_store
    true
  end
  def move_to_cache
    true    
  end

end
