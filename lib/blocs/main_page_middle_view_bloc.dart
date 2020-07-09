import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_thecolormarket/entities_e_models/cart.dart';
import 'package:re_thecolormarket/widgets/search_and_buy_widget.dart';

import 'cartbloc.dart';

enum MiddleViewEvent { itensForBuying, textoContador }

class MiddleViewBloc extends Bloc<MiddleViewEvent, Widget> {
  static BuildContext context;

  static void setContext({BuildContext newContext}) {
    context = newContext;
  }

  @override
  Widget get initialState => Container(
        color: Colors.red,
        child: Text(
          'ERROR',
          textAlign: TextAlign.center,
        ),
        height: 100,
        width: 100,
      );

  @override
  Stream<Widget> mapEventToState(MiddleViewEvent event) async* {
    switch (event) {
      case MiddleViewEvent.textoContador:
        debugPrint('Texto Contador Event was called');

        yield BlocBuilder<CartBloc, Cart>(
          builder: (context, myCart) {
            int numItens = myCart.getItensCount();
            debugPrint('Nº itens = $numItens');
            return Text('Itens no carrinho = $numItens');
          },
        );
        break;

      case MiddleViewEvent.itensForBuying:
        //Todo gera uma lista de itens para comprar, criar widget separado!
        debugPrint('Itens for Buying Event was called');
        yield SearchAndBuyWidget();
        break;

      //todo criar o evento carrinho que leva pro carrinho com a lista de itens adicionados!
    }
  }
}
