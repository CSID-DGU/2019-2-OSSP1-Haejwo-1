class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def filename
    "#{secure_token}#{original_filename}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

  storage :file

  version :thumb do
    # process resize_to_fill: [200,200]
    process resize_to_fit: [600,600]
  end

  version :square do
    process resize_to_fill: [640,640]
  end

  version :ratio do
    process resize_to_fit: [1600,1600]
  end
end
