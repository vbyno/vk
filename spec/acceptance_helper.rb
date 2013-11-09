require 'spec_helper'

module AcceptanceHelper
  def test_photo_path(width = 0, height = 0, extention = 'jpg')
    if width > 0 && height > 0
      Rails.root + "spec/support/#{width}x#{height}.#{extention}"
    else
      Rails.root + 'spec/support/test_photo.jpg'
    end
  end
end