class PhotoUploader < BasicImageUploader
  version :small_fixed_height do
    process resize_to_fit: [10000, 180]
  end

  version :small do
    process resize_to_fill: [485, 273]
  end

  version :thumb do
    process resize_to_fill: [80, 40]
  end
end
