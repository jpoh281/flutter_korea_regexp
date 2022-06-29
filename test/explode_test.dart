import 'package:korea_regexp/korea_regexp.dart';
import 'package:test/test.dart';

void main(){
  for (var element in [
    ['가까가', ['ㄱ', 'ㅏ', 'ㄲ', 'ㅏ', 'ㄱ', 'ㅏ']],
    ['깍두기', ['ㄲ', 'ㅏ', 'ㄱ', 'ㄷ', 'ㅜ', 'ㄱ', 'ㅣ']],
    ['불닭', ['ㅂ', 'ㅜ', 'ㄹ', 'ㄷ', 'ㅏ', 'ㄹ', 'ㄱ']],
    ['왜요', ['ㅇ', 'ㅗ', 'ㅐ', 'ㅇ', 'ㅛ']],
    ['있', ['ㅇ','ㅣ','ㅆ']],
    ['씼', ['ㅆ','ㅣ','ㅆ']],
  ]) {
    test('explode', () {
      expect(explode(element[0] as String), element[1]);
    });
  }
  test('grouped: true', () {
    expect(explode('불닭', grouped: true), [
      ['ㅂ', 'ㅜ', 'ㄹ'],
      ['ㄷ', 'ㅏ', 'ㄹ', 'ㄱ'],
    ]);
  });
}