import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/debug_bloc_delegate.dart';
import 'views/home_view.dart';
import 'views/shop_view.dart';
import 'components/title_bar.dart';
import 'bloc/player_bloc.dart';

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}


class _App extends State<App> {
  final PlayerBloc _playerBloc = PlayerBloc();
  
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = DebugBlocDelegate();
    return BlocProvider(
      create: (BuildContext context) => _playerBloc,
      child: MaterialApp(
        title: "Clicker Game",
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          typography: Typography.material2018(platform: TargetPlatform.android),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => AppBase(child: HomeView()),
          '/shop': (context) => AppBase(child: ShopView()),
        },
      )
    );
  }

  @override
  void dispose() {
    _playerBloc.dispose();
    super.dispose();
  }
}

class AppBase extends StatelessWidget {
  AppBase({Key key, this.child}):super(key: key);

  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.instance(context),
      body: child,
    );
  }
}

