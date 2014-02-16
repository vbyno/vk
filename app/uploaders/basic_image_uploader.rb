class BasicImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  after :remove, :delete_empty_upstream_dir
  process :watermarking

  version :full_screen do
    process resize_to_fit: [1920, 1080]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "#{model.class.to_s.underscore}.jpg" if original_filename
  end

  def watermarking
    manipulate! do |img|
      logo = MiniMagick::Image.open("#{Rails.root}/app/assets/images/watermark.png")
      # img = img.composite(logo, Magick::SouthEastGravity, Magick::OverCompositeOp)
      img = img.composite(logo, 'jpg') do |c|
        c.gravity 'center'
      end
    end
  end

  def extension_white_list
    %w[jpg jpeg png]
  end

  def delete_empty_upstream_dir
    path = ::File.expand_path(store_dir, root)
    FileUtils.rm_rf(path) # TODO not safe way!
  end
end
