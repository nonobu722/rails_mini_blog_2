class ImagesUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    include Cloudinary::CarrierWave
    process convert: 'jpg'
    process tags: ['image']

    version :standard do
      process resize_to_fill: [450, 300, :north]
    end

    version :thumbnail do
      process resize_to_fit: [100, 100]
    end

    def public_id
      'post/' + Cloudinary::Utils.random_public_id
    end
  else
    storage :file
  end
end
