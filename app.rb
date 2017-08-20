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
require_relative 'lib/calculo'
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
calcula_remocao_vies("GRANDE", timestamp)