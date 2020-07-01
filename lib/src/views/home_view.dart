import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/money_displayer.dart';
import '../bloc/player_bloc.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, player) {
        return Center(
          child: Column(
            children: <Widget>[
              MoneyDisplayer(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text(
                        "CLICK!",
                      ),
                      color: Colors.green,
                      onPressed: () => {
                        BlocProvider.of<PlayerBloc>(context)
                        .add(PlayerEvent.ButtonClicked)
                      },
                    ),
                  ),
                ],
              ),

              Text("Strength: ${player.strength}"),
              Text("Critical Chance: ${player.criticalChance}"),
              Text("Critical Power: ${player.criticalPower}"),
            ],
          )
        );
      }
    );
  }
}
