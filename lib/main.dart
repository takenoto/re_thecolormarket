import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_thecolormarket/blocs/cartbloc.dart';
import 'package:re_thecolormarket/pages/myhomepage.dart';

import 'blocs/main_page_middle_view_bloc.dart';

void main() {
//  SystemChrome.setSystemUIOverlayStyle(
//      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Contexto para ser usado pelo bloc:
    MiddleViewBloc.setContext(newContext: context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Color Market',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: BlocProvider<CartBloc>(
        //     create: (context) => CartBloc(), child: MyHomePage()),
        home: MultiBlocProvider(providers: [
          BlocProvider<CartBloc>(create: (context) => CartBloc()),
          BlocProvider<MiddleViewBloc>(create: (context) => MiddleViewBloc())
        ], child: MyHomePage()));
  }
}
