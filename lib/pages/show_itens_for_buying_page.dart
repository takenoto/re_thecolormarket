import 'package:flutter/material.dart';

class ItensForBuyingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //Aqui ficam os botões laterais, parece uma navigationRail! Mas feita na marra :o
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[],
          ),
        ),
        //Aqui fica a janela atual dos itens
        Expanded(
          child: Container(
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
