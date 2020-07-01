import 'package:bloc/bloc.dart';
import 'dart:math';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  @override PlayerState get initialState => PlayerState(0, 0, 0, 0);

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    switch(event) {
      case PlayerEvent.ButtonClicked:
        yield state.click();
        break;
      case PlayerEvent.StrengthIncremented:
        yield state.incrementStrengthLevel();
        break;
      case PlayerEvent.CriticalChanceIncremented:
        yield state.incrementCriticalChanceLevel();
        break;
      case PlayerEvent.CriticalPowerIncremented:
        yield state.incrementCriticalPowerLevel();
        break;
    }
  }

  void dispose() {
  }
}

enum PlayerEvent {
  ButtonClicked,
  StrengthIncremented,
  CriticalChanceIncremented,
  CriticalPowerIncremented
}


/// PlayerState
///
/// Represents current state and holds functions for generating The next state
/// based upon PlayerEvents

class PlayerState {
  final int strengthLevel;
  final int criticalChanceLevel;
  final int criticalPowerLevel;
  final int money;

  int get strength => strengthLevel + 1;
  double get criticalChance => criticalChanceLevel * 0.01 + 0.01;
  double get criticalPower => criticalPowerLevel * 0.15 + 1.5;
  
  const PlayerState(
    this.money,
    this.strengthLevel,
    this.criticalChanceLevel,
    this.criticalPowerLevel
  );

  int addMoney(int amount) {
    return max(money + amount, 0);
  }
  
  PlayerState click() {
    int amount;
    if(Random().nextDouble() < criticalChance) {
      amount = (strength * criticalPower).floor();
    }
    else {
      amount = strength;
    }
    return PlayerState(
      addMoney(amount),
      strengthLevel,
      criticalChanceLevel,
      criticalPowerLevel
    );
  }
  PlayerState incrementStrengthLevel() {
    return PlayerState(
      money,
      strengthLevel + 1,
      criticalChanceLevel,
      criticalPowerLevel
    );
  }
  PlayerState incrementCriticalChanceLevel() {
    return PlayerState(
      money,
      strengthLevel,
      criticalChanceLevel + 1,
      criticalPowerLevel
    );
  }
  PlayerState incrementCriticalPowerLevel() {
    return PlayerState(
      money,
      strengthLevel,
      criticalChanceLevel,
      criticalPowerLevel + 1
    );
  }
  //PlayerState click() {
  //const criticalChance =
  //}
}
