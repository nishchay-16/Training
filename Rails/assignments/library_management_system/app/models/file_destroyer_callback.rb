class FileDestroyerCallback
  def after_destroy(picture_file)
    puts "File deleted: #{picture_file.filepath}"
    if File.exist?(picture_file.filepath)
      File.delete(picture_file.filepath)
    end
  end
end