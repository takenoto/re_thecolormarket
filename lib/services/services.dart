import 'package:flutter/material.dart';
import 'package:re_thecolormarket/entities_e_models/item.dart';

Future<List<Item>> getListOfItensFromWeb(var tipo) async {
  //Simula espera
  await Future.delayed(Duration(seconds: 1));

  List<Item> listaDeItens = [];

  String baseName = '';
  String info = '';
  double precobase = -1;

  if (tipo == tipoDeItem.Baby) {
    baseName = 'Pessoa';
    info = '赤ちゃん';
    precobase = 100;
  } else if (tipo == tipoDeItem.BeachAcess) {
    baseName = 'Coisa';
    info = '海が好きか？砂浜を歩こう。';
    precobase = 10;
  } else if (tipo == tipoDeItem.Money) {
    baseName = 'Coisa';
    info = 'お金は大事だよ。幸せはお金じゃないけどお金がないと不幸になる。';
    precobase = 10;
  } else {
    baseName = '-----エラー-----';
    info = '-ERROR-';
    precobase = 0;
  }

  int num = 0;
  for (Color color in Colors.primaries) {
    if (color != Colors.black && color != Colors.white) {
      num++;
      listaDeItens.add(Item(
        name: '$baseName $num',
        tipo: tipo,
        color: color,
        info: info,
        priceInBRL: precobase + num,
      ));
    }
  }
  return listaDeItens;
}
