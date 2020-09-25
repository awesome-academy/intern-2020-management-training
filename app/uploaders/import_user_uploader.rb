class ImportUserUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    Rails.root.join("public", "uploads", "import_users")
  end

  def extension_whitelist
    %w(xlsx)
  end

  def filename
    return if original_filename.blank?

    apart_name_file = original_filename.split "."
    extension_file = apart_name_file.pop
    file_name = apart_name_file.join
    file_name + "_" + Time.zone.now.to_i.to_s + "." + extension_file
  end

  def size_range
    1.byte..5.megabytes
  end
end
