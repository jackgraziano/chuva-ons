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

    # carrega chuva nas subbacias
    sub_bacia.coordenadas.each do |c|
      key = sprintf("%.2f",c[:lat]).rjust(6, " ") + sprintf("%.2f",c[:lon]).rjust(6, " ")
      c[:chuva_ETA] = hash_ETA[key]
    end
    sub_bacia.calculo_ETA = Hash.new(0)

    # 1.1.1. Cálculo da precipitação média diária prevista
    # pmod eh o resultado do item 1.1.1
    pmod = Hash.new(0)
    sub_bacia.coordenadas.each do |c|
      (1..10).each do |i|
        pmod["D#{i}".to_sym] += c[:chuva_ETA]["D#{i}".to_sym] # soma chuvas em pmod
      end
    end
    (1..10).each do |i|
      pmod["D#{i}".to_sym] /= sub_bacia.coordenadas.count # tira a media das chuvas em pmod
      pmod["D#{i}".to_sym] = pmod["D#{i}".to_sym].round(2) # arredonda
    end

    # 1.1.2. Cálculo da precipitação média prevista acumulada em 10 dias
    pmod[:total] = ( pmod[:D1] + pmod[:D2] + pmod[:D3] + pmod[:D4] + pmod[:D5] +
                     pmod[:D6] + pmod[:D7] + pmod[:D8] + pmod[:D9] + pmod[:D10] ).round(2)
    sub_bacia.calculo_ETA[:pmod] = pmod
    sub_bacia.calculo_ETA[:ptotmod_10dias] = pmod[:total]

    # 1.1.3. Aplicação da equação de remoção do viés da previsão de precipitação
    a = sub_bacia.parametros["A_#{mes}".to_sym]
    b = sub_bacia.parametros["B_#{mes}".to_sym]
    if sub_bacia.calculo_ETA[:ptotmod_10dias] < sub_bacia.parametros["limite_#{mes}".to_sym]
      sub_bacia.calculo_ETA[:aplica_remocao] = true
      sub_bacia.calculo_ETA[:ptotprmod_10dias] = ( a * (sub_bacia.calculo_ETA[:ptotmod_10dias] ** 2) + b * sub_bacia.calculo_ETA[:ptotmod_10dias] ).round(2)
    else
      sub_bacia.calculo_ETA[:aplica_remocao] = false
      sub_bacia.calculo_ETA[:ptotprmod_10dias] = sub_bacia.calculo_ETA[:ptotmod_10dias]
    end

    # 1.2.1. Aplicação de limite máximo de dez dias
    lim_10dias = sub_bacia.parametros["lim_10_dias_#{mes}".to_sym]
    sub_bacia.calculo_ETA[:ptotprmod_10dias_lim] = [ sub_bacia.calculo_ETA[:ptotprmod_10dias], lim_10dias].min

    # 1.2.2. Discretização da precipitação prevista pelo modelo,
    # com remoção de viés e limite, acumulada em dez dias, em precipitação diária
    sub_bacia.calculo_ETA[:alfa] = ( sub_bacia.calculo_ETA[:ptotprmod_10dias_lim] / sub_bacia.calculo_ETA[:ptotprmod_10dias] ).round(2)
    pprlim_10dias = Hash.new(0)
    (1..10).each do |i|
      pprlim_10dias["D#{i}".to_sym] = sub_bacia.calculo_ETA[:alfa] * sub_bacia.calculo_ETA[:pmod]["D#{i}".to_sym]
    end
    pprlim_10dias[:total] = ( pprlim_10dias[:D1] + pprlim_10dias[:D2] +
                              pprlim_10dias[:D3] + pprlim_10dias[:D4] +
                              pprlim_10dias[:D5] + pprlim_10dias[:D6] +
                              pprlim_10dias[:D7] + pprlim_10dias[:D8] +
                              pprlim_10dias[:D9] + pprlim_10dias[:D10] ).round(2)
    sub_bacia.calculo_ETA[:pprlim_10dias] = pprlim_10dias

    # 1.2.3. Aplicação de limite máximo de um dia
    lim_1dia = sub_bacia.parametros["lim_diario_#{mes}".to_sym]
    pprlim_1dia = Hash.new(0)
    (1..10).each do |i|
      pprlim_1dia["D#{i}".to_sym] = [sub_bacia.calculo_ETA[:pprlim_10dias]["D#{i}".to_sym] , lim_1dia].min
    end
    sub_bacia.calculo_ETA[:pprlim_1dia] = pprlim_1dia

    #1.2.4. Obtenção da previsão de precipitação do ponto de grade, com remoção do viés e aplicação de limites
    beta = Hash.new(0)
    (1..10).each do |i|
      beta["D#{i}".to_sym] = sub_bacia.calculo_ETA[:pprlim_1dia]["D#{i}".to_sym] / sub_bacia.calculo_ETA[:pmod]["D#{i}".to_sym]
    end
    sub_bacia.calculo_ETA[:beta] = beta
  end

  # bacia.sub_bacias_GEFS.each do |sub_bacia|
  #   sub_bacia.coordenadas.each do |c|
  #     key = sprintf("%.2f",c[:lat]).rjust(6, " ") + sprintf("%.2f",c[:lon]).rjust(6, " ")
  #     chuva_GEFS = hash_GEFS[key]
  #     c[:chuva_GEFS] = chuva_GEFS
  #     c[:chuva_GEFS][:soma_10] = ( c[:chuva_GEFS][:D1] + c[:chuva_GEFS][:D2] + c[:chuva_GEFS][:D3] +
  #                                  c[:chuva_GEFS][:D4] + c[:chuva_GEFS][:D5] + c[:chuva_GEFS][:D6] +
  #                                  c[:chuva_GEFS][:D7] + c[:chuva_GEFS][:D8] + c[:chuva_GEFS][:D9] +
  #                                  c[:chuva_GEFS][:D10] ).round(2)
  #   end
  # end

end
