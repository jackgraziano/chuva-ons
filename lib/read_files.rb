def read_files(folder)
  files = list_files(folder)
  previsao = []
  hash = Hash.new(0)
  files.each do |file, index_chuva|
    puts "Lendo #{file}"
    File.open(file, "r") do |f|
      f.each_line do |line|
        lon = line[0..5]
        lat = line[7..12]
        key = lat + lon
        chuva = line[14..18]
        hash[key] = Hash.new(0) if hash[key] == 0
        hash[key][:lat] = lat.to_f
        hash[key][:lon] = lon.to_f
        hash[key][index_chuva.to_sym] = chuva.to_f
      end
    end
  end
  return hash
end

def list_files(folder)
  files_names = Dir["#{folder}/*"].sort
  files_names_and_ds = []
  files_names.each_with_index do |file_name, index|
    files_names_and_ds << [file_name, "D#{index + 1}"]
  end
  return files_names_and_ds
end
