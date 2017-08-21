class Bacia
  attr_accessor :nome, :sub_bacias_ETA, :sub_bacias_GEFS
  @sub_bacias_ETA = []
  @sub_bacias_GEFS = []
end

class SubBacia
  attr_accessor :nome,
                :coordenadas,
                :parametros,
                :calculo_ETA
  def initialize
    @coordenadas = []
  end
end

