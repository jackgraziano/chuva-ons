class SubBacia
  attr_accessor :nome, :coordenadas
  @coordenadas = []
end

class Bacia
  attr_accessor :nome, :sub_bacias_eta, :sub_bacias_gefs
  @sub_bacias_eta = []
  @sub_bacias_gefs = []
end

camargos = SubBacia.new
camargos.nome = "Camargos"
camargos.coordenadas = [ {lat:-21.40, lon: -44.20},
                         {lat:-21.40, lon: -44.60},
                         {lat:-21.80, lon: -44.20},
                         {lat:-21.80, lon: -44.60},
                         {lat:-22.20, lon: -44.60} ]

funil = SubBacia.new
funil.nome = "Funil"
funil.coordenadas = [ {lat:-21.00, lon: -43.80},
                      {lat:-21.00, lon: -44.20},
                      {lat:-21.00, lon: -44.60},
                      {lat:-21.00, lon: -45.00},
                      {lat:-21.40, lon: -43.80} ]

porto_dos_buenos = SubBacia.new
porto_dos_buenos.nome = "Porto dos Buenos"
porto_dos_buenos.coordenadas = [ {lat:-21.80, lon: -45.00},
                                 {lat:-21.80, lon: -45.40},
                                 {lat:-22.20, lon: -45.00},
                                 {lat:-22.20, lon: -45.40} ]

paraguacu = SubBacia.new
paraguacu.nome = "Paraguacu"
paraguacu.coordenadas = [ {lat:-21.80, lon: -45.80},
                          {lat:-22.20, lon: -45.80},
                          {lat:-22.20, lon: -46.20},
                          {lat:-22.60, lon: -45.40},
                          {lat:-22.60, lon: -45.80} ]

agua_vermelha = SubBacia.new
agua_vermelha.nome = "Água Vermelha"
agua_vermelha.coordenadas = [ {lat:-19.80, lon: -49.00},
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

grande_GR1 = SubBacia.new
grande_GR1.nome = "GR1 - Grande"
grande_GR1.coordenadas = [ {lat:-21.00, lon: -44.00},
                           {lat:-22.00, lon: -44.00},
                           {lat:-22.00, lon: -45.00},
                           {lat:-23.00, lon: -46.00} ]

grande_GR2 = SubBacia.new
grande_GR2.nome = "GR2 - Grande"
grande_GR2.coordenadas = [ {lat:-21.00, lon: -45.00},
                           {lat:-21.00, lon: -46.00},
                           {lat:-22.00, lon: -46.00} ]

grande_GR3 = SubBacia.new
grande_GR3.nome = "GR3 - Grande"
grande_GR3.coordenadas = [ {lat:-20.00, lon: -48.00},
                           {lat:-20.00, lon: -49.00},
                           {lat:-21.00, lon: -47.00},
                           {lat:-21.00, lon: -48.00} ]

grande_GR4 = SubBacia.new
grande_GR4.nome = "GR4 - Grande"
grande_GR4.coordenadas = [ {lat:-20.00, lon: -50.00},
                           {lat:-21.00, lon: -49.00},
                           {lat:-22.00, lon: -47.00} ]

grande = Bacia.new
grande.nome = "Bacia do Rio Grande"
grande.sub_bacias_eta = [camargos, funil, porto_dos_buenos, paraguacu, agua_vermelha]
grande.sub_bacias_gefs = [grande_GR1, grande_GR2, grande_GR3, grande_GR4]
