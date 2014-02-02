require 'spec_helper'
Dir[Rails.root.join('spec/requests/page_objects/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/requests/page_objects/**/*.rb')].each { |f| require f }

module AcceptanceHelper
  def test_photo_path(width = 0, height = 0, extention = 'jpg')
    if width > 0 && height > 0
      Rails.root + "spec/support/#{width}x#{height}.#{extention}"
    else
      Rails.root + 'spec/support/test_photo.jpg'
    end
  end
end
