import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:re_thecolormarket/blocs/cartbloc.dart';
import 'package:re_thecolormarket/blocs/main_page_middle_view_bloc.dart';

List<IconData> bottomIconData = [
  Icons.text_fields,
  Icons.home,
];

class SelectedButtomInfo extends ChangeNotifier {
  int _selectedBottomButton = 0;
  int previousIndex = 0;

  get selectedBottomButton => _selectedBottomButton;

  void updateSelectedButton({@required int newIndex}) {
    previousIndex = _selectedBottomButton;
    _selectedBottomButton = newIndex;
    notifyListeners();
  }

  bool isThisButtonSelected({@required int index}) {
    return index == _selectedBottomButton ? true : false;
  }
}

void mapItemIndexToEvent(
    {@required MiddleViewBloc middleViewBloc, @required int selectedIndex}) {
  //todo Se já for o index da vez, pula a função ao invés de recarregar!
  //Isto é: não recarregar o que já tá pronto zzz
  debugPrint('Bottom button index $selectedIndex pressed');

  switch (selectedIndex) {
    case 0:
      middleViewBloc.add(MiddleViewEvent.textoContador);
      break;
    case 1:
      middleViewBloc.add(MiddleViewEvent.itensForBuying);
      break;
    case 2:
      break;
    default:
      debugPrint('Ativou o default. Algo de errado não está certo.');
      break;
  }

  //TODO refatorar os botões embaixo, colocando essa forma mais automatizada e adicionando o botão carrinho!
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    final MiddleViewBloc middleViewBloc =
        BlocProvider.of<MiddleViewBloc>(context);

    //Obtém o widget do middleViewBloc
    Future<Widget> getMiddleWidget() async {
      return middleViewBloc.state;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('The Color Store'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 50,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                  Positioned(
                    left: 25,
                    bottom: 12,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      height: 15,
                      width: 15,
                      child: Text(
                        '0',
                        style: ThemeData.light().textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child:
                BlocBuilder<MiddleViewBloc, Widget>(builder: (context, widget) {
              return FutureBuilder(
                future: getMiddleWidget(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return widget;
                  } else {
                    debugPrint('Conection state = ${snapshot.connectionState}');
                    return CircularProgressIndicator();
                  }
                },
              );
            }),
          ),
          ChangeNotifierProvider(
            create: (context) => SelectedButtomInfo(),
            child: Container(
              color: Colors.blue,
              height: 100.0,
              child: BottomButtons(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Pressionou o botão de adicionar item');
          cartBloc.add(CartEvent.addItem);
        },
        child: Icon(Icons.plus_one),
      ),
    );
  }
}

//Novos botões:
class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedButtomInfo>(
      builder: (BuildContext context, SelectedButtomInfo selectedButtomInfo,
          Widget child) {
        MiddleViewBloc middleViewBloc =
            BlocProvider.of<MiddleViewBloc>(context);

        //Cria os botões pra colocar na Row
        List<Widget> buttons = [];
        bottomIconData.forEach((iconData) {
          final int thisButtonIndex = bottomIconData.indexOf(iconData);

          buttons.add(FlatButton(
            child: Icon(
              iconData,
              size: selectedButtomInfo.isThisButtonSelected(
                      index: thisButtonIndex)
                  ? 28
                  : 20,
              color: selectedButtomInfo.isThisButtonSelected(
                      index: thisButtonIndex)
                  ? Colors.white
                  : Colors.white70,
            ),
            onPressed: () {
              //Atualiza o botão selecionado
              selectedButtomInfo.updateSelectedButton(
                  newIndex: thisButtonIndex);
              mapItemIndexToEvent(
                  middleViewBloc: middleViewBloc,
                  selectedIndex: thisButtonIndex);
              print('Botão BottomButton nº $thisButtonIndex pressionado');
            },
          ));
        });

        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: buttons,
        );
      },
//      child: Row(
//        mainAxisSize: MainAxisSize.max,
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: buttons,
//      ),
    );
  }
}

//Antigos botões:
//IconButton(
//icon: Icon(Icons.text_fields),
//onPressed: () {
//middleViewBloc.add(MiddleViewEvent.textoContador);
//},
//),
//IconButton(
//icon: Icon(Icons.home),
//onPressed: () {
//middleViewBloc.add(MiddleViewEvent.itensForBuying);
//},
//)
