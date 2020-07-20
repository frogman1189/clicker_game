import 'package:bloc/bloc.dart';
import 'dart:math';
import '../math/math.dart';
import '../errors/not_in_test_error.dart';

bool testing = false;

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  @override PlayerState get initialState => PlayerState(0, 0, 0, 0);
  PlayerState _testState;

  
  void setTestState(PlayerState testState) {
    if(testing == true) {
      _testState = testState;
      add(PlayerEvent.TestStateSet);
    } else {
      throw NotInTestError();
    }
  }
  
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
      case PlayerEvent.TestStateSet:
        yield _testState;
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
  CriticalPowerIncremented,
  TestStateSet
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
  //static const upgradeCost = 10;

  int get upgradeCost => (strengthLevel + criticalChanceLevel + criticalPowerLevel + 1) * 3;
  int get strength => strengthLevel + 1;
  double get criticalChance => roundDouble(criticalChanceLevel * 0.01 + 0.01, 2);
  double get criticalPower => roundDouble(criticalPowerLevel * 0.15 + 1.5, 2);
  
  const PlayerState(
    this.money,
    this.strengthLevel,
    this.criticalChanceLevel,
    this.criticalPowerLevel
  );

  int _addMoney(int amount) {
    return max(money + amount, 0);
  }
  bool _hasEnoughMoney(int amount) {
    return money >= amount;
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
      _addMoney(amount),
      strengthLevel,
      criticalChanceLevel,
      criticalPowerLevel
    );
  }
  PlayerState incrementStrengthLevel() {
    return (_hasEnoughMoney(upgradeCost)) ?
    PlayerState(
      money - upgradeCost,
      strengthLevel + 1,
      criticalChanceLevel,
      criticalPowerLevel
    ) : this;
  }
  PlayerState incrementCriticalChanceLevel() {
    return (_hasEnoughMoney(upgradeCost)) ?
    PlayerState(
      money - upgradeCost,
      strengthLevel,
      criticalChanceLevel + 1,
      criticalPowerLevel
    ) : this;
  }
  PlayerState incrementCriticalPowerLevel() {
    return (_hasEnoughMoney(upgradeCost)) ?
    PlayerState(
      money - upgradeCost,
      strengthLevel,
      criticalChanceLevel,
      criticalPowerLevel + 1
    ) : this;
  }
  
  @override
  String toString() {
    return "{ money: $money, strength: $strengthLevel, criticalChance: $criticalChanceLevel, criticalPower: $criticalPowerLevel }";
  }

  @override
  int get hashCode {
    return money + (strengthLevel << 8) + (criticalChanceLevel << 16) + (criticalPowerLevel << 24);
  }

  @override
  bool operator ==(dynamic other) {
    if(other is! PlayerState) return false;
    PlayerState p = other;
    return (p.money == money)
    && (p.strengthLevel == strengthLevel)
    && (p.criticalChanceLevel == criticalChanceLevel)
    && (p.criticalPowerLevel == criticalPowerLevel);
  }
}
