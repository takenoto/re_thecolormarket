import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:re_thecolormarket/entities_e_models/cart.dart';
import 'package:re_thecolormarket/entities_e_models/item.dart';

import '../brain.dart';

const tipos = [tipoDeItem.Baby, tipoDeItem.BeachAcess, tipoDeItem.Money];
const icons = [Icons.child_care, Icons.beach_access, Icons.attach_money];

class ItemPesquisa extends ChangeNotifier {
  var _itemAPesquisar = tipoDeItem.Baby;
  int _selectedIndex = 0;

  get selectedIndex => _selectedIndex;
  get itemAPesquisar => _itemAPesquisar;

  void selectIndex(int newIndex) {
    _selectedIndex = newIndex;
    _itemAPesquisar = tipos[_selectedIndex];
    notifyListeners();
  }
}

class SearchAndBuyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemPesquisa(),
        )
      ],
      child: Column(
        children: <Widget>[
          Expanded(
            child: _ListaDeItens(),
          ),
        ],
      ),
    );
  }
}

class _SearchMaterial extends StatelessWidget {
  @override
  Widget build(Object context) {
    //Cria os buttons que vão ser usados
    List<Widget> buttons = [];
    for (var iconData in icons) {
      buttons.add(FlatButton(
        child: Icon(iconData),
        onPressed: () {
//todo alterar a variável global no provider e informar as views inferiores que foi alterado!
          Provider.of<ItemPesquisa>(context, listen: false)
              .selectIndex(icons.indexOf(iconData));

          debugPrint(
              'Ícone selecionado: index = %${Provider.of<ItemPesquisa>(context, listen: false).selectedIndex}');
        },
      ));
    }

    return Material(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          color: Colors.white,
          height: 100,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttons,
          ),
        ),
      ),
    );
  }
}

class _ListaDeItens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Para atualizar a pesquisa, obtemos o item selecionado pelo usuário:
    var itemAPesquisar = Provider.of<ItemPesquisa>(context).itemAPesquisar;

    return Consumer<ItemPesquisa>(
      builder: (BuildContext context, ItemPesquisa value, Widget child) {
        return FutureBuilder(
          future: Brain.getItens(forceNewItens: false, tipo: itemAPesquisar),
          builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Item> listaDeItens = snapshot.data;

              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: false,
                    floating: false,
                    elevation: 2,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Compre o que quiser!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SliverAppBar(
                    flexibleSpace: _SearchMaterial(),
                    pinned: false,
                    floating: true,
                    snap: true,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      if (index >= listaDeItens.length) return null;
                      Item currentItem = listaDeItens[index];

                      Widget priceText = Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          'R\$ ${currentItem.priceInBRL}',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                      );

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 4,
                          child: Container(
                            height: 100.0,
                            width: 50,
                            color: Colors.white,
                            padding: EdgeInsets.all(12),
                            child: (Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Spacer(
                                  flex: 1,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(
                                      currentItem.icon,
                                      color: currentItem.color,
                                    ),
                                  ],
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                Container(
                                  width: 1,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        currentItem.name.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14),
                                        softWrap: false,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        currentItem.info,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: currentItem.color),
                                        softWrap: false,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[priceText],
                                ),
                              ],
                            )),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            } else {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: false,
                    floating: false,
                    elevation: 2,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Compre o que quiser!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SliverAppBar(
                    flexibleSpace: _SearchMaterial(),
                    pinned: false,
                    floating: true,
                    snap: true,
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 100),
                      width: 100,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
