class BasicImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  after :remove, :delete_empty_upstream_dir

  def self.watermark_logo
    @watermark_logo ||=
      MiniMagick::Image.open("#{Rails.root}/app/assets/images/watermark.png")
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "#{model.class.to_s.underscore}.jpg" if original_filename
  end

  def extension_white_list
    %w[jpg jpeg png]
  end

  def delete_empty_upstream_dir
    path = ::File.expand_path(store_dir, root)
    FileUtils.rm_rf(path) # TODO not safe way!
  end
end
