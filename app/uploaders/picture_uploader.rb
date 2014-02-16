class PictureUploader < BasicImageUploader
  version :column_width do
    process resize_to_limit: [825, 1167] # A4
  end
end
