import 'package:korea_regexp/korea_regexp.dart';

var postPositions = [
  ['은', '는'],
  ['이', '가'],
  ['을', '를'],
  ['과', '와']
].fold(
    [],
    (value, element) => [
          ...value,
          [
            RegExp('''([가-힣]['" ]{0,1})${element[0]}\\(${element[1]}\\)'''),
            element[0],
            element[1]
          ],
          [
            RegExp('''([가-힣]['" ]{0,1})${element[1]}\\(${element[0]}\\)'''),
            element[0],
            element[1]
          ]
        ]);

correctPostpositions(String text) {
  return postPositions.fold<String>(text, (previousValue, element) {
    return previousValue.replaceAllMapped(element[0], (match) {
      return '${match[1]!.replaceAll(' ', '')}${getPhonemes(match[0]!).finale != '' ? element[1] : element[2]}';
    });
  });
}
