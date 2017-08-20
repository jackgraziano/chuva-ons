def download_file(link, file)
  File.open(file, "wb") do |f|
    f.write HTTParty.get(link).body
  end
end

def unzip_file(file, destiny)
  FileUtils::mkdir_p(destiny)
  Zip::File.open(file) do |zipfile|
    zipfile.each do |entry|
      entry.extract("#{destiny}/#{entry.name}")
    end
  end
end
