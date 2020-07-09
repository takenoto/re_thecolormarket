import 'package:flutter/material.dart';
import 'package:re_thecolormarket/services/services.dart';

import 'entities_e_models/item.dart';

class Brain {
  static List<Item> listaDeItens = [];

  static Future<List<Item>> getItens(
      {@required bool forceNewItens, @required var tipo}) async {
    listaDeItens = await getListOfItensFromWeb(tipo);
    return listaDeItens;

    if (listaDeItens.length <= 0 || forceNewItens) {
      //Se ainda não tiver pego nenhum item, simula busca na internet
      listaDeItens = await getListOfItensFromWeb(tipoDeItem.Baby);
      List<Item> itens2 = await getListOfItensFromWeb(tipoDeItem.BeachAcess);

      for (Item item in itens2) {
        listaDeItens.add(item);
      }

      List<Item> itens3 = await getListOfItensFromWeb(tipoDeItem.Money);
      for (Item item in itens3) {
        listaDeItens.add(item);
      }
    } else {
      //Se já tiver pego algo, simplesmente retorna!
      return listaDeItens;
    }

    return listaDeItens;
  }
}
