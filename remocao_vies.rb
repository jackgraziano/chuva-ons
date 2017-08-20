# config
require 'httparty'
require 'zip'
require 'fileutils'
require 'pry'
require_relative 'bacias'
include Bacias

Zip.on_exists_proc = true

link_eta = "http://www.ons.org.br/images/operacao_integrada/meteorologia/eta/Eta40_precipitacao10d.zip"
link_gefs = "http://www.ons.org.br/images/operacao_integrada/meteorologia/global/GEFS_precipitacao10d.zip"
file_eta = "/tmp/file_eta.zip"
file_gefs = "/tmp/file_gefs.zip"

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

def load_files(files)
  previsao = []
  hash = Hash.new(0)
  files.each do |file, index_chuva|
    puts "Lendo #{file}"
    File.open(file, "r") do |f|
      f.each_line do |line|
        lat = line[0..5]
        lon = line[7..12]
        chuva = line[14..18]
        key = line[0..5] + line[7..12]
        hash[key] = Hash.new(0) if hash[key] == 0
        hash[key][:lat] = lat.to_f
        hash[key][:lon] = lon.to_f
        hash[key][index_chuva.to_sym] = chuva.to_f
      end
    end
  end
  return hash
end

# timestamp =  Time.now.strftime("%Y%m%d_%H%M")
# download_file(link_eta, file_eta)
# download_file(link_gefs, file_gefs)
# unzip_file(file_eta, "#{timestamp}/eta")
# unzip_file(file_gefs, "#{timestamp}/gefs")
hash_ETA = load_files([
        ['20170819_1921/eta/ETA40_p190817a200817.dat', "D1"],
        ['20170819_1921/eta/ETA40_p190817a210817.dat', "D2"],
        ['20170819_1921/eta/ETA40_p190817a220817.dat', "D3"],
        ['20170819_1921/eta/ETA40_p190817a230817.dat', "D4"],
        ['20170819_1921/eta/ETA40_p190817a240817.dat', "D5"],
        ['20170819_1921/eta/ETA40_p190817a250817.dat', "D6"],
        ['20170819_1921/eta/ETA40_p190817a260817.dat', "D7"],
        ['20170819_1921/eta/ETA40_p190817a270817.dat', "D8"],
        ['20170819_1921/eta/ETA40_p190817a280817.dat', "D9"],
        ['20170819_1921/eta/ETA40_p190817a290817.dat', "D10"]
  ])

GRANDE.sub_bacias_eta.each do |sub_bacia|
  sub_bacia.coordenadas.each do |c|
    key = c[:lat].to_s.rjust(6, " ") + c[:lon].to_s.rjust(6, " ")
    chuva = hash_ETA[key]
    c[:chuva] = chuva
  end
end
