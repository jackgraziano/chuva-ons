module Grande
  CAMARGOS = SubBacia.new
  CAMARGOS.nome = "CAMARGOS"
  CAMARGOS.coordenadas = [ {lat:-21.40, lon: -44.20},
                           {lat:-21.40, lon: -44.60},
                           {lat:-21.80, lon: -44.20},
                           {lat:-21.80, lon: -44.60},
                           {lat:-22.20, lon: -44.60} ]
  CAMARGOS.parametros = {
                                  A_JAN: 0.00806,
                                  A_FEV: 0.00244,
                                  A_MAR: 0.00244,
                                  A_ABR: 0.00244,
                                  A_MAI: 0.00660,
                                  A_JUN: 0.00660,
                                  A_JUL: 0.00660,
                                  A_AGO: 0.00660,
                                  A_SET: 0.00432,
                                  A_OUT: 0.00432,
                                  A_NOV: 0.00432,
                                  A_DEZ: 0.00806,

                                  B_JAN: 0.01218,
                                  B_FEV: 0.65662,
                                  B_MAR: 0.65662,
                                  B_ABR: 0.65662,
                                  B_MAI: 0.41491,
                                  B_JUN: 0.41491,
                                  B_JUL: 0.41491,
                                  B_AGO: 0.41491,
                                  B_SET: 0.40059,
                                  B_OUT: 0.40059,
                                  B_NOV: 0.40059,
                                  B_DEZ: 0.01218,

                                  limite_JAN: 1000.0,
                                  limite_FEV: 140.7,
                                  limite_MAR: 140.7,
                                  limite_ABR: 140.7,
                                  limite_MAI: 88.7,
                                  limite_JUN: 88.7,
                                  limite_JUL: 88.7,
                                  limite_AGO: 88.7,
                                  limite_SET: 138.8,
                                  limite_OUT: 138.8,
                                  limite_NOV: 138.8,
                                  limite_DEZ: 1000.0,

                                  lim_10_dias_JAN: 158,
                                  lim_10_dias_FEV: 91,
                                  lim_10_dias_MAR: 91,
                                  lim_10_dias_ABR: 91,
                                  lim_10_dias_MAI: 23,
                                  lim_10_dias_JUN: 23,
                                  lim_10_dias_JUL: 23,
                                  lim_10_dias_AGO: 23,
                                  lim_10_dias_SET: 90,
                                  lim_10_dias_OUT: 90,
                                  lim_10_dias_NOV: 90,
                                  lim_10_dias_DEZ: 158,

                                  lim_diario_JAN: 31,
                                  lim_diario_FEV: 31,
                                  lim_diario_MAR: 31,
                                  lim_diario_ABR: 31,
                                  lim_diario_MAI: 31,
                                  lim_diario_JUN: 31,
                                  lim_diario_JUL: 31,
                                  lim_diario_AGO: 31,
                                  lim_diario_SET: 31,
                                  lim_diario_OUT: 31,
                                  lim_diario_NOV: 31,
                                  lim_diario_DEZ: 31,
  }


  FUNIL = SubBacia.new
  FUNIL.nome = "FUNIL"
  FUNIL.coordenadas = [ {lat:-21.00, lon: -43.80},
                        {lat:-21.00, lon: -44.20},
                        {lat:-21.00, lon: -44.60},
                        {lat:-21.00, lon: -45.00},
                        {lat:-21.40, lon: -43.80} ]

  PORTO_DOS_BUENOS = SubBacia.new
  PORTO_DOS_BUENOS.nome = "Porto dos Buenos"
  PORTO_DOS_BUENOS.coordenadas = [ {lat:-21.80, lon: -45.00},
                                   {lat:-21.80, lon: -45.40},
                                   {lat:-22.20, lon: -45.00},
                                   {lat:-22.20, lon: -45.40} ]

  PARAGUACU = SubBacia.new
  PARAGUACU.nome = "PARAGUACU"
  PARAGUACU.coordenadas = [ {lat:-21.80, lon: -45.80},
                            {lat:-22.20, lon: -45.80},
                            {lat:-22.20, lon: -46.20},
                            {lat:-22.60, lon: -45.40},
                            {lat:-22.60, lon: -45.80} ]

  AGUA_VERMELHA = SubBacia.new
  AGUA_VERMELHA.nome = "Água Vermelha"
  AGUA_VERMELHA.coordenadas = [ {lat:-19.80, lon: -49.00},
                                {lat:-19.80, lon: -49.40},
                                {lat:-19.80, lon: -49.80},
                                {lat:-19.80, lon: -50.20},
                                {lat:-20.20, lon: -49.40},
                                {lat:-20.20, lon: -49.80},
                                {lat:-20.20, lon: -50.20},
                                {lat:-20.60, lon: -49.00},
                                {lat:-20.60, lon: -49.40},
                                {lat:-21.00, lon: -48.60},
                                {lat:-21.00, lon: -49.00}
                              ]
  AGUA_VERMELHA.parametros = {
                                A_JAN: 0.001120,
                                A_FEV: 0.00105,
                                A_MAR: 0.00105,
                                A_ABR: 0.00105,
                                A_MAI: -0.04105,
                                A_JUN: -0.04105,
                                A_JUL: -0.04105,
                                A_AGO: -0.04105,
                                A_SET: 0.00172,
                                A_OUT: 0.00172,
                                A_NOV: 0.00172,
                                A_DEZ: 0.00112,

                                B_JAN: 0.58348,
                                B_FEV: 0.68752,
                                B_MAR: 0.68752,
                                B_ABR: 0.68752,
                                B_MAI: 2.09049,
                                B_JUN: 2.09049,
                                B_JUL: 2.09049,
                                B_AGO: 2.09049,
                                B_SET: 0.5827,
                                B_OUT: 0.5827,
                                B_NOV: 0.5827,
                                B_DEZ: 0.58348,

                                limite_JAN: 371.9,
                                limite_FEV: 297.6,
                                limite_MAR: 297.6,
                                limite_ABR: 297.6,
                                limite_MAI: 26.6,
                                limite_JUN: 26.6,
                                limite_JUL: 26.6,
                                limite_AGO: 26.6,
                                limite_SET: 242.6,
                                limite_OUT: 242.6,
                                limite_NOV: 242.6,
                                limite_DEZ: 371.9,

                                lim_10_dias_JAN: 143,
                                lim_10_dias_FEV: 95,
                                lim_10_dias_MAR: 95,
                                lim_10_dias_ABR: 95,
                                lim_10_dias_MAI: 30,
                                lim_10_dias_JUN: 30,
                                lim_10_dias_JUL: 30,
                                lim_10_dias_AGO: 30,
                                lim_10_dias_SET: 76,
                                lim_10_dias_OUT: 76,
                                lim_10_dias_NOV: 76,
                                lim_10_dias_DEZ: 143,

                                lim_diario_JAN: 29,
                                lim_diario_FEV: 29,
                                lim_diario_MAR: 29,
                                lim_diario_ABR: 29,
                                lim_diario_MAI: 29,
                                lim_diario_JUN: 29,
                                lim_diario_JUL: 29,
                                lim_diario_AGO: 29,
                                lim_diario_SET: 29,
                                lim_diario_OUT: 29,
                                lim_diario_NOV: 29,
                                lim_diario_DEZ: 29,
  }

  GRANDE_GR1 = SubBacia.new
  GRANDE_GR1.nome = "GR1 - Grande"
  GRANDE_GR1.coordenadas = [ {lat:-21.00, lon: -44.00},
                             {lat:-22.00, lon: -44.00},
                             {lat:-22.00, lon: -45.00},
                             {lat:-23.00, lon: -46.00} ]

  GRANDE_GR2 = SubBacia.new
  GRANDE_GR2.nome = "GR2 - Grande"
  GRANDE_GR2.coordenadas = [ {lat:-21.00, lon: -45.00},
                             {lat:-21.00, lon: -46.00},
                             {lat:-22.00, lon: -46.00} ]

  GRANDE_GR3 = SubBacia.new
  GRANDE_GR3.nome = "GR3 - Grande"
  GRANDE_GR3.coordenadas = [ {lat:-20.00, lon: -48.00},
                             {lat:-20.00, lon: -49.00},
                             {lat:-21.00, lon: -47.00},
                             {lat:-21.00, lon: -48.00} ]

  GRANDE_GR4 = SubBacia.new
  GRANDE_GR4.nome = "GR4 - Grande"
  GRANDE_GR4.coordenadas = [ {lat:-20.00, lon: -50.00},
                             {lat:-21.00, lon: -49.00},
                             {lat:-22.00, lon: -47.00} ]
  GRANDE_GR4.parametros = {
                                A_JAN: 0.00213,
                                A_FEV: 0.00312,
                                A_MAR: 0.00312,
                                A_ABR: 0.00312,
                                A_MAI: -0.04043,
                                A_JUN: -0.04043,
                                A_JUL: -0.04043,
                                A_AGO: -0.04043,
                                A_SET: -0.00068,
                                A_OUT: -0.00068,
                                A_NOV: -0.00068,
                                A_DEZ: 0.00213,

                                B_JAN: 0.48543,
                                B_FEV: 0.48100,
                                B_MAR: 0.48100,
                                B_ABR: 0.48100,
                                B_MAI: 1.99200,
                                B_JUN: 1.99200,
                                B_JUL: 1.99200,
                                B_AGO: 1.99200,
                                B_SET: 0.86686,
                                B_OUT: 0.86686,
                                B_NOV: 0.86686,
                                B_DEZ: 0.48543,

                                limite_JAN: 241.6,
                                limite_FEV: 166.3,
                                limite_MAR: 166.3,
                                limite_ABR: 166.3,
                                limite_MAI: 24.5,
                                limite_JUN: 24.5,
                                limite_JUL: 24.5,
                                limite_AGO: 24.5,
                                limite_SET: 1000.0,
                                limite_OUT: 1000.0,
                                limite_NOV: 1000.0,
                                limite_DEZ: 241.6,

                                lim_10_dias_JAN: 140,
                                lim_10_dias_FEV: 93,
                                lim_10_dias_MAR: 93,
                                lim_10_dias_ABR: 93,
                                lim_10_dias_MAI: 29,
                                lim_10_dias_JUN: 29,
                                lim_10_dias_JUL: 29,
                                lim_10_dias_AGO: 29,
                                lim_10_dias_SET: 80,
                                lim_10_dias_OUT: 80,
                                lim_10_dias_NOV: 80,
                                lim_10_dias_DEZ: 140,

                                lim_diario_JAN: 27,
                                lim_diario_FEV: 27,
                                lim_diario_MAR: 27,
                                lim_diario_ABR: 27,
                                lim_diario_MAI: 27,
                                lim_diario_JUN: 27,
                                lim_diario_JUL: 27,
                                lim_diario_AGO: 27,
                                lim_diario_SET: 27,
                                lim_diario_OUT: 27,
                                lim_diario_NOV: 27,
                                lim_diario_DEZ: 27,
  }

  GRANDE = Bacia.new
  GRANDE.nome = "Bacia do Rio Grande"
  GRANDE.sub_bacias_ETA = [CAMARGOS, AGUA_VERMELHA]
  # GRANDE.sub_bacias_GEFS = [GRANDE_GR4]
end
