import 'package:korea_regexp/src/eng_to_kor.dart';
import 'package:test/test.dart';

main() {
  group('engToKor', () {
    [
      ['gksrmfskf', '한글날'],
      ['Rkrenrl, xhdekfr', '깍두기, 통닭'],
    ].forEach((e) {
      final before = e.first;
      final after = e.last;
      test('engToKor $before → $after', () {
        expect(engToKor(before), after);
      });
    });
  });
}
