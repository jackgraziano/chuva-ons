# gems
require 'httparty'
require 'zip'
require 'fileutils'
require 'pry'

# requires
require_relative 'lib/bacia'
require_relative 'lib/download'
require_relative 'lib/read_files'
require_relative 'bacias/dados_bacias'
include DadosBacias

# config
Zip.on_exists_proc = true

# variaveis
link_eta = "http://www.ons.org.br/images/operacao_integrada/meteorologia/eta/Eta40_precipitacao10d.zip"
link_gefs = "http://www.ons.org.br/images/operacao_integrada/meteorologia/global/GEFS_precipitacao10d.zip"
file_eta = "/tmp/file_eta.zip"
file_gefs = "/tmp/file_gefs.zip"

# faz download e le arquivos
timestamp =  Time.now.strftime("%Y%m%d")
download_file(link_eta, file_eta)
download_file(link_gefs, file_gefs)
unzip_file(file_eta, "#{timestamp}/eta")
unzip_file(file_gefs, "#{timestamp}/gefs")
hash_ETA = read_files("#{timestamp}/eta")
hash_GEFS = read_files("#{timestamp}/gefs")

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
