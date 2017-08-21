def calcula_remocao_vies(nome_bacia, data, repo)
  bacia = DadosBacias.const_get(nome_bacia)
  hash_ETA = read_files("#{repo}/#{data}/eta")
  hash_GEFS = read_files("#{repo}/#{data}/gefs")

  # retorna mes (JAN, FEV, ...)
  meses = { "01": "JAN", "02": "FEV", "03": "MAR", "04": "ABR",
            "05": "MAI", "06": "JUN", "07": "JUL", "08": "AGO",
            "09": "SET", "10": "OUT", "11": "NOV", "12": "DEZ" }
  mes = meses[data[4..5].to_sym]

  # Calculo ETA
  bacia.sub_bacias_ETA.each do |sub_bacia|
    sub_bacia.coordenadas.each do |c|
      key = sprintf("%.2f",c[:lat]).rjust(6, " ") + sprintf("%.2f",c[:lon]).rjust(6, " ")
      chuva_ETA = hash_ETA[key]
      c[:chuva_ETA] = chuva_ETA
      c[:chuva_ETA][:soma_10] = ( c[:chuva_ETA][:D1] + c[:chuva_ETA][:D2] + c[:chuva_ETA][:D3] +
                                  c[:chuva_ETA][:D4] + c[:chuva_ETA][:D5] + c[:chuva_ETA][:D6] +
                                  c[:chuva_ETA][:D7] + c[:chuva_ETA][:D8] + c[:chuva_ETA][:D9] +
                                  c[:chuva_ETA][:D10] ).round(2)
      # aplicar equacao de remocao de vies
      if c[:chuva_ETA][:soma_10] < sub_bacia.parametros["limite_#{mes}".to_sym]
        # aplicar eq de remocao de vies
        c[:aplicar_remocao] = true
        soma_10 = c[:chuva_ETA][:soma_10]
        a = sub_bacia.parametros["A_#{mes}".to_sym]
        b = sub_bacia.parametros["B_#{mes}".to_sym]
        c[:Ptotpr_mod10dias] = (a * (soma_10 ** 2) + b * soma_10).round(2)
      else
        # fazer o que? eh isso?
        c[:aplicar_remocao] = false
        soma_10 = c[:chuva_ETA][:soma_10]
        c[:Ptotpr_mod10dias] = soma_10
      end

      # limite de 10 dias
      c[:Ptotpr_mod10dias_lim] = [ c[:Ptotpr_mod10dias], sub_bacia.parametros["lim_10_dias_#{mes}".to_sym] ].min

      # alfa
      c[:alfa] = c[:Ptotpr_mod10dias] == 0 ? 0 : (c[:Ptotpr_mod10dias_lim] / c[:Ptotpr_mod10dias]).round(2)
      c[:chuva_ETA_ajust] = Hash.new(0)
      c[:chuva_ETA_ajust_lim] = Hash.new(0)
      lim_diario = sub_bacia.parametros["lim_diario_#{mes}".to_sym]
      # serie de 10 dias ajustada
      (1..10).each do |i|
        c[:chuva_ETA_ajust]["D#{i}".to_sym] = c[:chuva_ETA]["D#{i}".to_sym] * c[:alfa]
        c[:chuva_ETA_ajust_lim]["D#{i}".to_sym] = [c[:chuva_ETA_ajust]["D#{i}".to_sym], lim_diario].min
      end
      c[:chuva_ETA_ajust][:soma_10] = ( c[:chuva_ETA_ajust][:D1] + c[:chuva_ETA_ajust][:D2] +
                                        c[:chuva_ETA_ajust][:D3] + c[:chuva_ETA_ajust][:D4] +
                                        c[:chuva_ETA_ajust][:D5] + c[:chuva_ETA_ajust][:D6] +
                                        c[:chuva_ETA_ajust][:D7] + c[:chuva_ETA_ajust][:D8] +
                                        c[:chuva_ETA_ajust][:D9] + c[:chuva_ETA_ajust][:D10] ).round(2)

      c[:chuva_ETA_ajust_lim][:soma_10] = ( c[:chuva_ETA_ajust_lim][:D1] + c[:chuva_ETA_ajust_lim][:D2] +
                                            c[:chuva_ETA_ajust_lim][:D3] + c[:chuva_ETA_ajust_lim][:D4] +
                                            c[:chuva_ETA_ajust_lim][:D5] + c[:chuva_ETA_ajust_lim][:D6] +
                                            c[:chuva_ETA_ajust_lim][:D7] + c[:chuva_ETA_ajust_lim][:D8] +
                                            c[:chuva_ETA_ajust_lim][:D9] + c[:chuva_ETA_ajust_lim][:D10] ).round(2)
    end
  end

  bacia.sub_bacias_GEFS.each do |sub_bacia|
    sub_bacia.coordenadas.each do |c|
      key = sprintf("%.2f",c[:lat]).rjust(6, " ") + sprintf("%.2f",c[:lon]).rjust(6, " ")
      chuva_GEFS = hash_GEFS[key]
      c[:chuva_GEFS] = chuva_GEFS
      c[:chuva_GEFS][:soma_10] = ( c[:chuva_GEFS][:D1] + c[:chuva_GEFS][:D2] + c[:chuva_GEFS][:D3] +
                                   c[:chuva_GEFS][:D4] + c[:chuva_GEFS][:D5] + c[:chuva_GEFS][:D6] +
                                   c[:chuva_GEFS][:D7] + c[:chuva_GEFS][:D8] + c[:chuva_GEFS][:D9] +
                                   c[:chuva_GEFS][:D10] ).round(2)
    end
  end

end
