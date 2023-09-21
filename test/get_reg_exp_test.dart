import 'package:korea_regexp/korea_regexp.dart';
import 'package:test/test.dart';

void main(){
  for (var e in [
    ['대한민ㄱ', '대한민[ㄱ가-깋]'],
    ['대한민구', '대한민[구-귛]'],
    ['대한민국', '대한민(국|구[가-깋])'],
    ['온라이', '온라[이-잏]'],
    ['깎', '(깎|까[까-낗]|깍[가-깋])'],
    ['뷁', '(뷁|뷀[가-깋])'],
    ['korea', 'korea'],
  ]) {
    test('getRegExp ${e[0]} → ${e[1]}',
        () => {expect(getRegExp(e[0], RegExpOptions()), RegExp(e[1]))});
  }

  test(
      'initialSearch: false (default)',
      () => {
            expect(getRegExp('ㅎㄱ', RegExpOptions(initialSearch: false)),
                getRegExp('ㅎㄱ', RegExpOptions(initialSearch: false))),
            expect(getRegExp('ㅎㄱ', RegExpOptions(initialSearch: false)),
                RegExp('ㅎ[ㄱ가-깋]')),
            expect(getRegExp('^ㅎㄱ\$', RegExpOptions(initialSearch: false)),
                RegExp('^ㅎㄱ\$'))
          });

  test(
      'initialSearch: true',
      () => {
            expect(getRegExp('ㅎㄱ', RegExpOptions(initialSearch: true)),
                RegExp('[ㅎ하-힣][ㄱ가-깋]')),
            expect(getRegExp('^ㅎㄱ\$', RegExpOptions(initialSearch: true)),
                RegExp('^[ㅎ하-힣][ㄱ가-깋]\$'))
          });

  test(
      'startsWith: false',
      () => {
            expect(getRegExp('ㅎㄱ', RegExpOptions(startsWith: false)),
                getRegExp('ㅎㄱ', RegExpOptions(startsWith: false))),
            expect(getRegExp('ㅎㄱ', RegExpOptions(startsWith: false)),
                RegExp('ㅎ[ㄱ가-깋]')),
            expect(getRegExp('^ㅎㄱ\$', RegExpOptions(startsWith: false)),
                RegExp('^ㅎㄱ\$'))
          });

  test(
      'startsWith: true',
      () => {
            expect(getRegExp('ㅎㄱ', RegExpOptions(startsWith: true)),
                RegExp('^ㅎ[ㄱ가-깋]')),
            expect(getRegExp('^ㅎㄱ\$', RegExpOptions(startsWith: true)),
                RegExp('^\^ㅎㄱ\$'))
          });

  test(
      'endsWith: false',
      ()  {
            expect(getRegExp('ㅎㄱ', RegExpOptions(endsWith: false)),
                getRegExp('ㅎㄱ', RegExpOptions(endsWith: false)));
            expect(getRegExp('ㅎㄱ', RegExpOptions(endsWith: false)),
                RegExp('ㅎ[ㄱ가-깋]'));
            expect(getRegExp('^ㅎㄱ\$', RegExpOptions(endsWith: false)),
                RegExp('^ㅎㄱ\$'));
          });

  test(
      'endsWith: true',
      ()  {
            expect(getRegExp('ㅎㄱ', RegExpOptions(endsWith: true)),
                RegExp('ㅎ[ㄱ가-깋]\$'));
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
                RegExp('ㅎ[ㄱ가-깋]'));
          });

  test(
      'ignoreCase: true',
      ()  {
            expect(getRegExp('ㅎㄱ', RegExpOptions(ignoreCase: true)),
                RegExp('ㅎ[ㄱ가-깋]', caseSensitive: false));
          });

  RegExp fuzzyFalse =
      getRegExp('ㅋㅍ', RegExpOptions(initialSearch: true, fuzzy: false));
  List<String> words = ['카페', '카카오페이', '카페오레', '카메라', '아카펠라'];
  List<String> matched1 = words.where((e) => fuzzyFalse.hasMatch(e)).toList();
  test(
      'fuzzy: false',
      () {
            expect(matched1, ['카페', '카페오레', '아카펠라']);
          });

  RegExp fuzzyTrue =
  getRegExp('ㅋㅍ', RegExpOptions(initialSearch: true, fuzzy: true));
  List<String> matched2 = words.where((e) => fuzzyTrue.hasMatch(e)).toList();
  test(
      'fuzzy: true',
          () {
        expect(matched2, ['카페', '카카오페이', '카페오레', '아카펠라']);
      });
}
