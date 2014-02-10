class PictureUploader < BasicImageUploader
  version :to_show do
    process resize_to_fit: [600, 600]
  end
end
