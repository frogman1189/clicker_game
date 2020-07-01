import 'package:test/test.dart';
import 'package:clicker_game/src/math/math.dart';

main() {
  group('Test round function', () {
      /// 1 decimal place
      test('12.14 rounds to 12.1', () {
          expect(roundDouble(12.14, 1), 12.1);
      });
      test('12.15 rounds to 12.2', () {
          expect(roundDouble(12.15, 1), 12.2);
      });

      /// 2 decimal places
      test('100.541 rounds to 100.54', () {
          expect(roundDouble(100.541, 2), 100.54);
      });
      test('100.545 rounds to 100.545', () {
        expect(roundDouble(100.545, 2), 100.55);
      });
  });
}
