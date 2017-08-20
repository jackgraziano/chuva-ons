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

hash_GEFS = load_files([
        ['20170819_1921/gefs/GEFS_p190817a200817.dat', "D1"],
        ['20170819_1921/gefs/GEFS_p190817a210817.dat', "D2"],
        ['20170819_1921/gefs/GEFS_p190817a220817.dat', "D3"],
        ['20170819_1921/gefs/GEFS_p190817a230817.dat', "D4"],
        ['20170819_1921/gefs/GEFS_p190817a240817.dat', "D5"],
        ['20170819_1921/gefs/GEFS_p190817a250817.dat', "D6"],
        ['20170819_1921/gefs/GEFS_p190817a260817.dat', "D7"],
        ['20170819_1921/gefs/GEFS_p190817a270817.dat', "D8"],
        ['20170819_1921/gefs/GEFS_p190817a280817.dat', "D9"],
        ['20170819_1921/gefs/GEFS_p190817a290817.dat', "D10"]
  ])

GRANDE.sub_bacias_ETA.each do |sub_bacia|
  sub_bacia.coordenadas.each do |c|
    key = sprintf("%.2f",c[:lat]).rjust(6, " ") + sprintf("%.2f",c[:lon]).rjust(6, " ")
    chuva_ETA = hash_ETA[key]
    c[:chuva_ETA] = chuva_ETA
  end
end

GRANDE.sub_bacias_GEFS.each do |sub_bacia|
  sub_bacia.coordenadas.each do |c|
    key = sprintf("%.2f",c[:lat]).rjust(6, " ") + sprintf("%.2f",c[:lon]).rjust(6, " ")
    chuva_GEFS = hash_GEFS[key]
    c[:chuva_GEFS] = chuva_GEFS
  end
end

# calcula remoção de viés

# calcula soma dos 10 dias
GRANDE.sub_bacias_ETA.each do |sub_bacia|
  sub_bacia.coordenadas.each do |c|
    c[:chuva_ETA][:soma_10] = ( c[:chuva_ETA][:D1] + c[:chuva_ETA][:D2] + c[:chuva_ETA][:D3] +
                                c[:chuva_ETA][:D4] + c[:chuva_ETA][:D5] + c[:chuva_ETA][:D6] +
                                c[:chuva_ETA][:D7] + c[:chuva_ETA][:D8] + c[:chuva_ETA][:D9] +
                                c[:chuva_ETA][:D10] ).round(2)
    # c[:chuva_ETA][:media_10] = ( c[:chuva_ETA][:soma_10] / 10 ).round(2)
  end
end

GRANDE.sub_bacias_GEFS.each do |sub_bacia|
  sub_bacia.coordenadas.each do |c|
    c[:chuva_GEFS][:soma_10] = ( c[:chuva_GEFS][:D1] + c[:chuva_GEFS][:D2] + c[:chuva_GEFS][:D3] +
                                 c[:chuva_GEFS][:D4] + c[:chuva_GEFS][:D5] + c[:chuva_GEFS][:D6] +
                                 c[:chuva_GEFS][:D7] + c[:chuva_GEFS][:D8] + c[:chuva_GEFS][:D9] +
                                 c[:chuva_GEFS][:D10] ).round(2)
    c[:chuva_GEFS][:media_10] = ( c[:chuva_GEFS][:soma_10] / 10 ).round(2)
  end
end

sub_bacia = GRANDE.sub_bacias_ETA[4]
# aplicar equacao de remocao de vies
sub_bacia.coordenadas.each do |c|
  if c[:chuva_ETA][:soma_10] < sub_bacia.parametros[:limite_AGO]
    # aplicar eq de remocao de vies
    c[:aplicar_remocao] = true
    soma_10 = c[:chuva_ETA][:soma_10]
    a = sub_bacia.parametros[:A_AGO]
    b = sub_bacia.parametros[:B_AGO]
    c[:Ptotpr_mod10dias] = (a * (soma_10 ** 2) + b * soma_10).round(2)
  else
    # fazer o que? eh isso?
    c[:aplicar_remocao] = false
    soma_10 = c[:chuva_ETA][:soma_10]
    c[:Ptotpr_mod10dias] = soma_10
  end
end

# limite de 10 dias
sub_bacia.coordenadas.each do |c|
  c[:Ptotpr_mod10dias_lim] = [ c[:Ptotpr_mod10dias], sub_bacia.parametros[:lim_10_dias_AGO] ].min
end
