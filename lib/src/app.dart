import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/debug_bloc_delegate.dart';
import 'views/home_view.dart';
import 'views/shop_view.dart';
import 'components/title_bar.dart';
import 'bloc/player_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = DebugBlocDelegate();
    return BlocProvider<PlayerBloc>(
      create: (context) => PlayerBloc(),
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


//--------------------------------------------------------------------------
class BlocApp extends StatefulWidget {
  @override
  _BlocApp createState() => _BlocApp();
}


class _BlocApp extends State<BlocApp> {
  final PlayerBloc _playerBloc = PlayerBloc();
  //final StatBloc _statBloc = StatBloc();
  
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = DebugBlocDelegate();
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayerBloc>(
          create: (BuildContext context) => _playerBloc,
        ),
        //BlocProvider<StatBloc>(
        //  create: (BuildContext context) => _statBloc,
        //)
      ],
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
    //_statBloc.dispose();
    super.dispose();
  }
}
