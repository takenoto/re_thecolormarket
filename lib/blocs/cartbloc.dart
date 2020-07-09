import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_thecolormarket/entities_e_models/cart.dart';
import 'package:re_thecolormarket/entities_e_models/item.dart';

enum CartEvent { addItem, removeItem }

class CartBloc extends Bloc<CartEvent, Cart> {
  @override
  Cart get initialState => Cart();

  @override
  Stream<Cart> mapEventToState(CartEvent event) async* {
    switch (event) {
      case CartEvent.addItem:
        debugPrint('CartEvent.addItem was called');
        Cart.itens.add(defaultItem);
        yield Cart();
        break;
      case CartEvent.removeItem:
        debugPrint('CartEvent.removeItem was called');
        //todo fazer remover por index, não o último!
        Cart.itens.removeLast();
        yield Cart();
        break;
    }
  }

  //---------------------------------------------------------------------
  //---------------------------------------------------------------------
  //---------------------------------------------------------------------
  //útil para debug:
  static final Item defaultItem = Item(
      name: 'itemDefaultName',
      info: 'Item 1nf0: This is a high quality item.',
      priceInBRL: 2000.50,
      color: Colors.yellow,
      tipo: tipoDeItem.Baby);

  //Esse item deve ser modificado para representar o que deseja-se adicionar!
  Item itemASerAdicionado = defaultItem;
}
