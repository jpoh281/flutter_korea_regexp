import 'package:korea_regexp/korea_regexp.dart';
import 'package:test/test.dart';

void main(){
  for (var element in [
    ['ㅗ디ㅣㅐ 재깅!', 'hello world!'],
    ['ㅠㅁ차 새 솓 려셕ㄷ', 'back to the future'],
  ]) {
    test('korToEng', () {
      expect(korToEng(element[0]), element[1]);
    });
  }
}