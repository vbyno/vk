class PhotoUploader < BasicImageUploader
  process :watermarking

  version :full_screen do
    process resize_to_fit: [1920, 1080]
  end

  version :small_fixed_height do
    process resize_to_fit: [10000, 180]
  end

  version :small do
    process resize_to_fill: [485, 273]
  end

  version :medium do
    process resize_to_fill: [768, 432]
  end

  version :thumb do
    process resize_to_fill: [80, 40]
  end

  def watermarking
    manipulate! do |img|
      # img = img.composite(logo, Magick::SouthEastGravity, Magick::OverCompositeOp)
      img = img.composite(watermark_logo, 'jpg') do |c|
        c.gravity 'center'
      end
    end
  end
end
