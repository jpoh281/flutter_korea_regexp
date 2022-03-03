import 'package:flutter_test/flutter_test.dart';
import 'package:korea_regexp/korea_regexp.dart';

void main(){
  [
    ['가까가', ['ㄱ', 'ㅏ', 'ㄲ', 'ㅏ', 'ㄱ', 'ㅏ']],
    ['깍두기', ['ㄲ', 'ㅏ', 'ㄱ', 'ㄷ', 'ㅜ', 'ㄱ', 'ㅣ']],
    ['불닭', ['ㅂ', 'ㅜ', 'ㄹ', 'ㄷ', 'ㅏ', 'ㄹ', 'ㄱ']],
  ].forEach((element) {
    test('explode', () {
      expect(explode(element[0] as String), element[1]);
    });
  });
  test('grouped: true', () {
    expect(explode('불닭', grouped: true), [
      ['ㅂ', 'ㅜ', 'ㄹ'],
      ['ㄷ', 'ㅏ', 'ㄹ', 'ㄱ'],
    ]);
  });
}