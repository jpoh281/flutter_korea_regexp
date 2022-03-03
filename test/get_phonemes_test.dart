import 'package:flutter_test/flutter_test.dart';
import 'package:korea_regexp/korea_regexp.dart';

void main (){
  List<List<dynamic>> getPhonemesTest = [
    ['ㄱ', ['ㄱ', '', '']],
    ['가', ['ㄱ', 'ㅏ', '']],
    ['각', ['ㄱ', 'ㅏ', 'ㄱ']],
    ['ㅎ', ['ㅎ', '', '']],
    ['히', ['ㅎ', 'ㅣ', '']],
    ['힣', ['ㅎ', 'ㅣ', 'ㅎ']],
    ['뷁', ['ㅂ', 'ㅞ', 'ㄺ']],
  ];
  getPhonemesTest.forEach((element) {
    var char = element[0];
    var initial = element[1][0];
    var medial = element[1][1];
    var finale = element[1][2];
    var phonemes = getPhonemes(char);
    test('getPhonemesTest', () {
      expect(phonemes.initial, initial);
      expect(phonemes.medial, medial);
      expect(phonemes.finale, finale);
    });
  });
}