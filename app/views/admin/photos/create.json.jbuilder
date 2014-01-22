json.id @photo.id
json.url @photo.image.fixed_size.url
json.size @photo.image.size
json.destroy_link admin_apartment_photos_path(@photo.apartment, @photo)