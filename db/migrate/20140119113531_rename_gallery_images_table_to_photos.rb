class RenameGalleryImagesTableToPhotos < ActiveRecord::Migration
  class GalleryImage < ActiveRecord::Base; end
  class Photo < ActiveRecord::Base; end

  def change
    rename_table :gallery_images, :photos
  end
end
