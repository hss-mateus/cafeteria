ActiveSupport::Inflector.inflections(:pt_br) do |inflect|
  # general rule: add "s" to the end of the word
  # casa - casas
  inflect.plural(/^([A-zÀ-ú]*)a$/i, '\1as')
  # pe - pes
  inflect.plural(/^([A-zÀ-ú]*)e$/i, '\1es')
  # no example
  inflect.plural(/^([A-zÀ-ú]*)i$/i, '\1is')
  # carro - carros
  inflect.plural(/^([A-zÀ-ú]*)o$/i, '\1os')
  # pneu - pneus
  inflect.plural(/^([A-zÀ-ú]*)u$/i, '\1us')

  # if word ends in "r" or "z", add "es"
  # luz - luzes
  # flor - flores
  # arroz - arrozes
  inflect.plural(/^([A-zÀ-ú]*)r$/i, '\1res')
  inflect.plural(/^([A-zÀ-ú]*)z$/i, '\1zes')

  # if word ends in "al", "el", "ol", "ul": change "l" to "is"
  # farol - farois
  # hospital - hospitais
  # telemovel - telemoveis
  # pincel - pinceis
  # anzol - anzois
  inflect.plural(/^([A-zÀ-ú]*)al$/i, '\1ais')
  inflect.plural(/^([A-zÀ-ú]*)el$/i, '\1eis')
  inflect.plural(/^([A-zÀ-ú]*)ol$/i, '\1ois')
  inflect.plural(/^([A-zÀ-ú]*)ul$/i, '\1uis')

  # if word ends in "il" and has tónic accent in last syllable, change "il" to "is"
  # cantil - cantis
  inflect.plural(/^([A-zÀ-ú]*)il$/i, '\1is')

  # if word ends in "m", change "m" to "ns"
  # armazem - armazens
  # portagem - portagens
  inflect.plural(/^([A-zÀ-ú]*)m$/i, '\1ns')

  # if word ends in "ão", there are three ways of plural: ãos, ães, ões
  #
  # cão - cães
  # colchão - colchões
  # portão - portões
  # pão - pães
  # alemão - alemães
  # pilhão - pilhões
  # canhão - canhões
  # bidão - bidões
  # mão - mãos
  inflect.plural(/^([A-zÀ-ú]*)ao$/i, '\1oes')
  inflect.plural(/^([A-zÀ-ú]*)ão$/i, '\1ões')

  ############################
  # singular rules           #
  ############################

  # pes - pe
  # carros - carro
  # pneus - pneu
  inflect.singular(/^([A-zÀ-ú]*)as$/i, '\1a')
  inflect.singular(/^([A-zÀ-ú]*)es$/i, '\1e')
  inflect.singular(/^([A-zÀ-ú]*)is$/i, '\1i')
  inflect.singular(/^([A-zÀ-ú]*)os$/i, '\1o')
  inflect.singular(/^([A-zÀ-ú]*)us$/i, '\1u')

  # luzes - luz
  # flores - flor
  # arrozes - arroz
  inflect.singular(/^([A-zÀ-ú]*)res$/i, '\1r')
  inflect.singular(/^([A-zÀ-ú]*)zes$/i, '\1z')

  # cantis - cantil
  inflect.singular(/^([A-zÀ-ú]*)is$/i, '\1il')

  # farois - farol
  # hospitais - hospital
  # telemoveis - telemovel
  # pinceis - pincel
  # anzois - anzol
  inflect.singular(/^([A-zÀ-ú]*)ais$/i, '\1al')
  inflect.singular(/^([A-zÀ-ú]*)eis$/i, '\1el')
  inflect.singular(/^([A-zÀ-ú]*)ois$/i, '\1ol')
  inflect.singular(/^([A-zÀ-ú]*)uis$/i, '\1ul')

  # armazens - armazem
  # portagens - portagem
  inflect.singular(/^([A-zÀ-ú]*)ns$/i, '\1m')

  # cães - cão
  # colchões - colchão
  inflect.singular(/^([A-zÀ-ú]*)oes$/i, '\1ao')
  inflect.singular(/^([A-zÀ-ú]*)aes$/i, '\1ao')
  inflect.singular(/^([A-zÀ-ú]*)aos$/i, '\1ao')
end
