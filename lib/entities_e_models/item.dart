import 'package:flutter/material.dart';

enum tipoDeItem { Baby, BeachAcess, Money }

class Item {
  final String name, info;
  final double priceInBRL;
  Color color;
  IconData icon = Icons.crop_square;
  var tipo;
  Item(
      {@required this.name,
      @required this.priceInBRL,
      @required this.info,
      @required this.color,
      @required this.tipo}) {
    //Seleciona um ícone dependendo do tipo
    switch (tipo) {
      case tipoDeItem.Baby:
        icon = Icons.child_care;
        break;
      case tipoDeItem.BeachAcess:
        icon = Icons.beach_access;
        break;
      case tipoDeItem.Money:
        icon = Icons.attach_money;
        break;
    }
  }
}
