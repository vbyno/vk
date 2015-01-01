module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end

    def watermarking(watermark_image, position)
      manipulate! do |img|
        img = img.composite(watermark_image, 'jpg') do |c|
          c.gravity(position.to_s)
        end
      end
    end
  end
end

