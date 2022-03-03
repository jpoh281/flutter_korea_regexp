import 'package:flutter_test/flutter_test.dart';
import 'package:korea_regexp/korea_regexp.dart';

void main(){
  [
    ['ㅗ디ㅣㅐ 재깅!', 'hello world!'],
    ['ㅠㅁ차 새 솓 려셕ㄷ', 'back to the future'],
  ].forEach((element) {
    test('korToEng', () {
      expect(korToEng(element[0]), element[1]);
    });
  });
}