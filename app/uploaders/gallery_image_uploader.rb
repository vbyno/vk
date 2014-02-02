class GalleryImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  SIZES_TO_FILL = {
    small: [350, 200],
    thumb: [80, 40]
  }.freeze
  SIZES_TO_FIT = {
    full_screen: [1920, 1080],
    small_fixed_height: [10000, 180]
  }.freeze

  storage :file
  after :remove, :delete_empty_upstream_dir
  process :watermarking

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

  SIZES_TO_FIT.each do |name, sizes|
    version(name) { process resize_to_fit: sizes }
  end

  SIZES_TO_FILL.each do |name, sizes|
    version(name) { process resize_to_fill: sizes }
  end

  def extension_white_list
    %w[jpg jpeg png]
  end

  def delete_empty_upstream_dir
    path = ::File.expand_path(store_dir, root)
    FileUtils.rm_rf(path) # TODO not safe way!
  end
end
