import 'package:korea_regexp/constant.dart';
import 'package:korea_regexp/explode.dart';

Map<String, String> KR_TO_EN =
    Map.fromIterables(KEYS.map((e) => e[0]), KEYS.map((e) => e[1]));

korToEng(String text) {
  return text
      .split('')
      .map((char) =>
          (explode(char, grouped: false)).map((String e) => KR_TO_EN[e] ?? e))
      .expand((element) => element)
      .toList()
      .join('');
}
