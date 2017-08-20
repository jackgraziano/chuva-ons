# config
require 'httparty'
require 'zip'
require 'fileutils'
require 'pry'
require_relative 'bacias'

Zip.on_exists_proc = true

link_eta = "http://www.ons.org.br/images/operacao_integrada/meteorologia/eta/Eta40_precipitacao10d.zip"
link_gefs = "http://www.ons.org.br/images/operacao_integrada/meteorologia/global/GEFS_precipitacao10d.zip"
file_eta = "/tmp/file_eta.zip"
file_gefs = "/tmp/file_gefs.zip"

class PrevisaoCoordenada
  attr_accessor :lat, :long, :chuva_1, :chuva_2, :chuva_3, :chuva_4, :chuva_5,
                :chuva_6, :chuva_7, :chuva_8, :chuva_9, :chuva_10
  def initialize(lat, long)
    @lat = lat
    @long = long
  end
end

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

def load_file
  previsao = []
  files = [
        ['20170819_1921/eta/ETA40_p190817a200817.dat', 1],
        ['20170819_1921/eta/ETA40_p190817a210817.dat', 2],
        ['20170819_1921/eta/ETA40_p190817a220817.dat', 3],
        ['20170819_1921/eta/ETA40_p190817a230817.dat', 4],
        ['20170819_1921/eta/ETA40_p190817a240817.dat', 5],
        ['20170819_1921/eta/ETA40_p190817a250817.dat', 6],
        ['20170819_1921/eta/ETA40_p190817a260817.dat', 7],
        ['20170819_1921/eta/ETA40_p190817a270817.dat', 8],
        ['20170819_1921/eta/ETA40_p190817a280817.dat', 9],
        ['20170819_1921/eta/ETA40_p190817a290817.dat', 10]
  ]

  files.each do |file, index_chuva|
    puts "Lendo #{file}"
    File.open(file, "r") do |f|
      f.each_line do |line|
        lat = line[0..5].to_f
        long = line[7..12].to_f
        chuva = line[14..18].to_f
        index = previsao.index { |obj| obj.lat == lat && obj.long == long }
        if index.nil?
          ponto = PrevisaoCoordenada.new(lat, long)
          ponto.send("chuva_#{index_chuva}=".to_sym, chuva)
          previsao << ponto
        else
          previsao[index].send("chuva_#{index_chuva}=".to_sym, chuva)
        end
      end
    end
  end
  return previsao
end

# timestamp =  Time.now.strftime("%Y%m%d_%H%M")
# download_file(link_eta, file_eta)
# download_file(link_gefs, file_gefs)
# unzip_file(file_eta, "#{timestamp}/eta")
# unzip_file(file_gefs, "#{timestamp}/gefs")
# previsao = load_file
