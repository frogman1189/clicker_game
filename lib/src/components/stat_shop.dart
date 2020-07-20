import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../bloc/player_bloc.dart";

class StatShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, player) {
          return Column(
            children: <Widget> [
              Row(
                children: <Widget> [
                  Expanded(
                    child:Text("Strength Level: ${player.strengthLevel}")
                  ),
                  Expanded(
                    child:FlatButton(
                      child: Text("UPGRADE (-10)"),
                      color: Colors.green,
                      onPressed: () => {
                        BlocProvider.of<PlayerBloc>(context)
                        .add(PlayerEvent.StrengthIncremented)
                      }
                    )
                  ),
                ],
              ),
              Row(
                children: <Widget> [
                  Expanded(
                    child:Text("Critical Chance Level: ${player.criticalChanceLevel}"),
                  ),
                  Expanded(
                    child:FlatButton(
                      child: Text("UPGRADE (-10)"),
                      color: Colors.green,
                      onPressed: () => {
                        BlocProvider.of<PlayerBloc>(context)
                        .add(PlayerEvent.CriticalChanceIncremented)
                      }
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget> [
                  Expanded(
                    child: Text("Critical Power Level: ${player.criticalPowerLevel}"),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Text("UPGRADE (-10)"),
                      color: Colors.green,
                      onPressed: () => {
                        BlocProvider.of<PlayerBloc>(context)
                        .add(PlayerEvent.CriticalPowerIncremented)
                      }
                    ),
                  ),
                ],
              ),
            ]
          );
        }
      )
    );
  }
}
