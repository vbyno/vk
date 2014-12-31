class PhotoUploader < BasicImageUploader
  version :full_screen do
    process resize_to_fit: [1920, 1080]
    process :watermarking
    process quality: 75
  end

  version :medium do
    process resize_to_fill: [768, 432]
    process :watermarking
    process quality: 75
  end

  version :small do
    process resize_to_fill: [485, 273]
    process quality: 70
  end

  version :thumb do
    process resize_to_fill: [80, 40]
    process quality: 70
  end

private
  def watermarking
    manipulate! do |img|
      # img = img.composite(logo, Magick::SouthEastGravity, Magick::OverCompositeOp)
      img = img.composite(watermark_logo, 'jpg') do |c|
        c.gravity 'center'
      end
    end
  end
end

