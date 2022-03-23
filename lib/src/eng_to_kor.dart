import 'package:korea_regexp/src/constant.dart';
import 'package:korea_regexp/src/implode.dart';

final EN_TO_KR = Map<String, String>.fromIterable(keys,
    key: (e) => e.last, value: (e) => e.first);

String engToKor(String eng) {
  final kor = eng.split('').map((char) => EN_TO_KR[char] ?? char).join();
  return implode(kor);
}
