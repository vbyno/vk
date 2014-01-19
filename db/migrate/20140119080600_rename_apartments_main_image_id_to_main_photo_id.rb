class RenameApartmentsMainImageIdToMainPhotoId < ActiveRecord::Migration
  def change
    rename_column :apartments, :main_image_id, :main_photo_id
  end
end
