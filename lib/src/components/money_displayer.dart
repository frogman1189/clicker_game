import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/player_bloc.dart';

class MoneyDisplayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Text("Money",
          style: Theme.of(context).textTheme.headline4,
        ),
        BlocBuilder<PlayerBloc, PlayerState>(
          builder: (context, player) {
            return Text("${player.money}");
          },
        ),
      ],
    );
  }
}
