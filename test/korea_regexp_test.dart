import 'package:flutter_test/flutter_test.dart';
import 'package:korea_regexp/correct_postpositions.dart';
import 'package:korea_regexp/kor_to_eng.dart';
import 'package:korea_regexp/explode.dart';
import 'package:korea_regexp/get_phonemes.dart';
import 'package:korea_regexp/get_regexp.dart';
import 'package:korea_regexp/models/regexp_options.dart';

void main() {
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

  [
    ['ㅗ디ㅣㅐ 재깅!', 'hello world!'],
    ['ㅠㅁ차 새 솓 려셕ㄷ', 'back to the future'],
  ].forEach((element) {
    test('korToEng', () {
      expect(korToEng(element[0]),element[1]);
    });
  });

  // [
  // ['전쟁와(과) 평화', '전쟁과 평화'],
  // ['죄와(과) 벌', '죄와 벌'],
  // ['설탕은(는) 달다', '설탕은 달다'],
  // ['고양이은(는) 건드리지 마라', '고양이는 건드리지 마라'],
  // ['홍길동이(가) 홍상직을(를) 만났다', '홍길동이 홍상직을 만났다'],
  // ['토끼이(가) 거북이을(를) 만났다', '토끼가 거북이를 만났다'],
  // ['''"토끼"이(가) '거북이'을(를) 만났다''', '''"토끼"가 '거북이'를 만났다'''],
  // ['고양이 은(는) 건드리지 마라', '고양이는 건드리지 마라'],
  // ].forEach((element) {
  //   test('correctPostpositions ${element[0]} => ${element[1]}', (){
  //     expect(correctPostpositions(element[0]), element[1]);
  //   }
  //   );
  // });

  [
    ['대한민ㄱ', '대한민[가-깋]'],
    ['대한민구', '대한민[구-귛]'],
    ['대한민국', '대한민(국|구[가-깋])'],
    ['온라이', '온라[이-잏]'],
    ['깎', '(깎|까[까-낗]|깍[가-깋])'],
    ['뷁', '(뷁|뷀[가-깋])'],
    ['korea', 'korea'],
  ].forEach((e) {
    test('getRegExp ${e[0]} → ${e[1]}',
        () => {expect(getRegExp(e[0], RegExpOptions()), RegExp(e[1]))});
  });

  test(
      'initialSearch: false (default)',
      () => {
            expect(getRegExp('ㅎㄱ', RegExpOptions(initialSearch: false)),
                getRegExp('ㅎㄱ', RegExpOptions(initialSearch: false))),
            expect(getRegExp('ㅎㄱ', RegExpOptions(initialSearch: false)),
                RegExp('ㅎ[가-깋]')),
            expect(getRegExp('^ㅎㄱ\$', RegExpOptions(initialSearch: false)),
                RegExp('^ㅎㄱ\$'))
          });

  test(
      'initialSearch: true',
      () => {
            expect(getRegExp('ㅎㄱ', RegExpOptions(initialSearch: true)),
                RegExp('[하-힣][가-깋]')),
            expect(getRegExp('^ㅎㄱ\$', RegExpOptions(initialSearch: true)),
                RegExp('^[하-힣][가-깋]\$'))
          });

  test(
      'startsWith: false',
      () => {
            expect(getRegExp('ㅎㄱ', RegExpOptions(startsWith: false)),
                getRegExp('ㅎㄱ', RegExpOptions(startsWith: false))),
            expect(getRegExp('ㅎㄱ', RegExpOptions(startsWith: false)),
                RegExp('ㅎ[가-깋]')),
            expect(getRegExp('^ㅎㄱ\$', RegExpOptions(startsWith: false)),
                RegExp('^ㅎㄱ\$'))
          });

  test(
      'startsWith: true',
      () => {
            expect(getRegExp('ㅎㄱ', RegExpOptions(startsWith: true)),
                RegExp('^ㅎ[가-깋]')),
            expect(getRegExp('^ㅎㄱ\$', RegExpOptions(startsWith: true)),
                RegExp('^\^ㅎㄱ\$'))
          });

  test(
      'endsWith: false',
      ()  {
            expect(getRegExp('ㅎㄱ', RegExpOptions(endsWith: false)),
                getRegExp('ㅎㄱ', RegExpOptions(endsWith: false)));
            expect(getRegExp('ㅎㄱ', RegExpOptions(endsWith: false)),
                RegExp('ㅎ[가-깋]'));
            expect(getRegExp('^ㅎㄱ\$', RegExpOptions(endsWith: false)),
                RegExp('^ㅎㄱ\$'));
          });

  test(
      'endsWith: true',
      ()  {
            expect(getRegExp('ㅎㄱ', RegExpOptions(endsWith: true)),
                RegExp('ㅎ[가-깋]\$'));
            expect(getRegExp('^ㅎㄱ\$', RegExpOptions(endsWith: true)),
                RegExp('^ㅎㄱ\$\$'));
          });

  test(
      'ignoreSpace: false',
      ()  {
            expect(getRegExp('한글날', RegExpOptions(ignoreSpace: false)),
                getRegExp('한글날', RegExpOptions(ignoreSpace: false)));
            expect(getRegExp('한글날', RegExpOptions(ignoreSpace: false)),
                RegExp('한글(날|나[라-맇])'));
          });

  test(
      'ignoreSpace: true',
      ()  {
            expect(getRegExp('한글날', RegExpOptions(ignoreSpace: true)),
                RegExp('한\s*글\s*(날|나[라-맇])'));
          });

  test(
      'ignoreCase: false',
      () {
            expect(getRegExp('ㅎㄱ', RegExpOptions(ignoreCase: false)),
                getRegExp('ㅎㄱ', RegExpOptions(ignoreCase: false)));
            expect(getRegExp('ㅎㄱ', RegExpOptions(ignoreCase: false)),
                RegExp('ㅎ[가-깋]'));
          });

  test(
      'ignoreCase: true',
      ()  {
            expect(getRegExp('ㅎㄱ', RegExpOptions(ignoreCase: true)),
                RegExp('ㅎ[가-깋]', caseSensitive: false));
          });

  RegExp fuzzyFalse =
      getRegExp('ㅋㅍ', RegExpOptions(initialSearch: true, fuzzy: false));
  List<String> words = ['카페', '카카오페이', '카페오레', '카메라', '아카펠라'];
  List<String> mached1 = words.where((e) => fuzzyFalse.hasMatch(e)).toList();
  test(
      'fuzzy: false',
      () {
            expect(mached1, ['카페', '카페오레', '아카펠라']);
          });

  RegExp fuzzyTrue =
  getRegExp('ㅋㅍ', RegExpOptions(initialSearch: true, fuzzy: true));
  List<String> mached2 = words.where((e) => fuzzyTrue.hasMatch(e)).toList();
  test(
      'fuzzy: true',
          () {
        expect(mached2, ['카페', '카카오페이', '카페오레', '아카펠라']);
      });
}
