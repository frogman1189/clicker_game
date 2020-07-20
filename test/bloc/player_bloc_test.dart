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
  });


  group('button click without critical chance acts as expected', () {
      PlayerBloc playerBloc;
      setUp(() {
          testing = true;
          playerBloc = PlayerBloc();
          playerBloc.setTestState(PlayerState(0, 0, -1, 0)); // disable critical
      });
      blocTest('Clicking button 10 times gives correct state',
        build: () async => playerBloc,
        act: (bloc) async { for(int i = 0; i < 10; i++) bloc.add(PlayerEvent.ButtonClicked); },
        expect: [
          PlayerState(1,0,-1,0),
          PlayerState(2,0,-1,0),
          PlayerState(3,0,-1,0),
          PlayerState(4,0,-1,0),
          PlayerState(5,0,-1,0),
          PlayerState(6,0,-1,0),
          PlayerState(7,0,-1,0),
          PlayerState(8,0,-1,0),
          PlayerState(9,0,-1,0),
          PlayerState(10,0,-1,0),
        ]
      );
  });
  
  /// Upgrade Fails
  group('PlayerBloc Cash and stat unchanged when failing to upgrade', () {
      PlayerBloc playerBloc;
      setUp(() {
          testing = true;
          playerBloc = PlayerBloc();
          playerBloc.setTestState(PlayerState(9, 0, 0, 0));
      });
      blocTest(
        'emits {9,0,0,0} when PlayerEvent.StrengthIncremented is added and fails',
        build: () async => playerBloc,
        act: (bloc) async => bloc.add(PlayerEvent.StrengthIncremented),
        expect: [],
      );
      blocTest(
        'emits {9,0,0,0} when PlayerEvent.CriticalChanceIncremented is added and fails',
        build: () async => playerBloc,
        act: (bloc) async => bloc.add(PlayerEvent.CriticalChanceIncremented),
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
          testing = true;
          playerBloc = PlayerBloc();
          playerBloc.setTestState(PlayerState(10, 0, 0, 0));
      });
      blocTest(
        'emits {0,1,0,0} when PlayerEvent.StrengthIncremented is added and fails',
        build: () async => playerBloc,
        act: (bloc) async => bloc.add(PlayerEvent.StrengthIncremented),
        expect: [PlayerState(0, 1, 0, 0)],
      );
      blocTest(
        'emits {0,0,1,0} when PlayerEvent.CriticalChanceIncremented is added and fails',
        build: () async => playerBloc,
        act: (bloc) async => bloc.add(PlayerEvent.CriticalChanceIncremented),
        expect: [PlayerState(0, 0, 1, 0)],
      );
      blocTest(
        'emits {0,0,0,1} when PlayerEvent.CriticalPowerIncremented is added and fails',
        build: () async => playerBloc,
        act: (bloc) async => bloc.add(PlayerEvent.CriticalPowerIncremented),
        expect: [PlayerState(0, 0, 0, 1)],
      );
  });

  group('Button clicks with increased strength get expected values', () {
      PlayerBloc playerBloc;
      setUp(() {
          testing = true;
          playerBloc = PlayerBloc();
      });
      blocTest('strengthLevel 1 gets expected results',
        build: () async {
          playerBloc.setTestState(PlayerState(0, 1, -1, 0));
          return playerBloc;
        },
        act: (bloc) async {
          for(int i = 0; i < 5; i++) {
            bloc.add(PlayerEvent.ButtonClicked);
          }
        },
        expect: [
          PlayerState(2, 1, -1, 0),
          PlayerState(4, 1, -1, 0),
          PlayerState(6, 1, -1, 0),
          PlayerState(8, 1, -1, 0),
          PlayerState(10, 1, -1, 0),
        ]
      );

      blocTest('strengthLevel 1 starting from a large prime gets expected results',
        build: () async {
          playerBloc.setTestState(PlayerState(3877, 1, -1, 0));
          return playerBloc;
        },
        act: (bloc) async {
          for(int i = 0; i < 5; i++) {
            bloc.add(PlayerEvent.ButtonClicked);
          }
        },
        expect: [
          PlayerState(3879, 1, -1, 0),
          PlayerState(3881, 1, -1, 0),
          PlayerState(3883, 1, -1, 0),
          PlayerState(3885, 1, -1, 0),
          PlayerState(3887, 1, -1, 0),
        ]
      );

      blocTest('strengthLevel 9 gets expected results',
        build: () async {
          playerBloc.setTestState(PlayerState(0, 9, -1, 0));
          return playerBloc;
        },
        act: (bloc) async {
          for(int i = 0; i < 5; i++) {
            bloc.add(PlayerEvent.ButtonClicked);
          }
        },
        expect: [
          PlayerState(10, 9, -1, 0),
          PlayerState(20, 9, -1, 0),
          PlayerState(30, 9, -1, 0),
          PlayerState(40, 9, -1, 0),
          PlayerState(50, 9, -1, 0),
        ]
      );
      blocTest('strengthLevel 9 gets expected results when starting from large prime',
        build: () async {
          playerBloc.setTestState(PlayerState(8513, 9, -1, 0));
          return playerBloc;
        },
        act: (bloc) async {
          for(int i = 0; i < 5; i++) {
            bloc.add(PlayerEvent.ButtonClicked);
          }
        },
        expect: [
          PlayerState(8523, 9, -1, 0),
          PlayerState(8533, 9, -1, 0),
          PlayerState(8543, 9, -1, 0),
          PlayerState(8553, 9, -1, 0),
          PlayerState(8563, 9, -1, 0),
        ]
      );
      

      blocTest('strengthLevel 1023 gets expected results',
        build: () async {
          playerBloc.setTestState(PlayerState(0, 1023, -1, 0));
          return playerBloc;
        },
        act: (bloc) async {
          for(int i = 0; i < 5; i++) {
            bloc.add(PlayerEvent.ButtonClicked);
          }
        },
        expect: [
          PlayerState(1024, 1023, -1, 0),
          PlayerState(2048, 1023, -1, 0),
          PlayerState(3072, 1023, -1, 0),
          PlayerState(4096, 1023, -1, 0),
          PlayerState(5120, 1023, -1, 0),
        ]
      );

      blocTest('strengthLevel 1023 gets expected results when starting from large prime',
        build: () async {
          playerBloc.setTestState(PlayerState(6263, 1023, -1, 0));
          return playerBloc;
        },
        act: (bloc) async {
          for(int i = 0; i < 5; i++) {
            bloc.add(PlayerEvent.ButtonClicked);
          }
        },
        expect: [
          PlayerState(7287, 1023, -1, 0),
          PlayerState(8311, 1023, -1, 0),
          PlayerState(9335, 1023, -1, 0),
          PlayerState(10359, 1023, -1, 0),
          PlayerState(11383, 1023, -1, 0),
        ]
      );
  });
}
