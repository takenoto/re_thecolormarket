import 'item.dart';

class Cart {
  static List<Item> itens = [];

  void addItem(Item item) {
    itens.add(item);
  }

  List<Item> getItens() {
    return itens;
  }

  int getItensCount() {
    return itens.length;
  }
}
