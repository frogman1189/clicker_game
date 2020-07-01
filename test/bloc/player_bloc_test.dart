import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:clicker_game/src/bloc/player_bloc.dart';

void main() {
  /// Initial State
  group('PlayerBloc Initial State', () {
      PlayerBloc playerBloc;
      setUp(() {
          playerBloc = PlayerBloc();
      });

      test('initial state money is 0', () {
          expect(playerBloc.initialState.money, 0);
      });
      test('initial state strengthLevel is 0', () {
          expect(playerBloc.initialState.strengthLevel, 0);
      });
      test('initial state criticalChanceLevel is 0', () {
          expect(playerBloc.initialState.criticalChanceLevel, 0);
      });
      test('initial state criticalPowerLevel is 0', () {
          expect(playerBloc.initialState.criticalPowerLevel, 0);
      });
      blocTest('Clicking button 10 times gives correct state',
        build: () async => playerBloc,
        act: (bloc) async { for(int i = 0; i < 10; i++) bloc.add(PlayerEvent.ButtonClicked); },
        expect: [
          //Player(0,0,0,0),
          PlayerState(1,0,0,0),
          PlayerState(2,0,0,0),
          PlayerState(3,0,0,0),
          PlayerState(4,0,0,0),
          PlayerState(5,0,0,0),
          PlayerState(6,0,0,0),
          PlayerState(7,0,0,0),
          PlayerState(8,0,0,0),
          PlayerState(9,0,0,0),
          PlayerState(10,0,0,0),
        ]
      );
  });


  
  /// Upgrade Fails
  group('PlayerBloc Cash and stat unchanged when failing to upgrade', () {
      PlayerBloc playerBloc;
      setUp(() {
          testing = true;
          playerBloc = PlayerBloc();
          
      });
      blocTest(
        'emits {9,0,0,0} when PlayerEvent.StrengthIncremented is added and fails',
        build: () async => playerBloc,
        act: (bloc) async => bloc.add(PlayerEvent.StrengthIncremented),
        skip: 9,
        expect: [],
      );
      blocTest(
        'emits {9,0,0,0} when PlayerEvent.CriticalChanceIncremented is added and fails',
        build: () async => playerBloc,
        act: (bloc) async => bloc.add(PlayerEvent.CriticalChanceIncremented),
        skip: 9,
        expect: [],
      );
      blocTest(
        'emits {9,0,0,0} when PlayerEvent.CriticalPowerIncremented is added and fails',
        build: () async => playerBloc,
        act: (bloc) async => bloc.add(PlayerEvent.CriticalPowerIncremented),
        skip: 9,
        expect: [],
      );
  });

  /// Upgrade Succeeds
  group('PlayerBloc Cash and stat changed when upgrade succeeds', () {
      PlayerBloc playerBloc;
      setUp(() {
          playerBloc = PlayerBloc();
          for(int i = 0; i < 10; i++) {
            playerBloc.add(PlayerEvent.ButtonClicked);
          }
          testing = true;
      });
      blocTest(
        'emits {0,1,0,0} when PlayerEvent.StrengthIncremented is added and fails',
        build: () async => playerBloc,
        act: (bloc) async => bloc.add(PlayerEvent.StrengthIncremented),
        skip: 10,
        expect: [PlayerState(0, 1, 0, 0)],
      );
      blocTest(
        'emits {0,0,1,0} when PlayerEvent.CriticalChanceIncremented is added and fails',
        build: () async => playerBloc,
        act: (bloc) async => bloc.add(PlayerEvent.CriticalChanceIncremented),
        skip: 10,
        expect: [PlayerState(0, 0, 1, 0)],
      );
      blocTest(
        'emits {0,0,0,1} when PlayerEvent.CriticalPowerIncremented is added and fails',
        build: () async => playerBloc,
        act: (bloc) async => bloc.add(PlayerEvent.CriticalPowerIncremented),
        skip: 10,
        expect: [PlayerState(0, 0, 0, 1)],
      );
  });
}
