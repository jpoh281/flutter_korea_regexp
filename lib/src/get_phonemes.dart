import 'package:korea_regexp/src/constant.dart';
import 'package:korea_regexp/src/models/phonemes_result.dart';

PhonemesResult getPhonemes(String char) {
  var initial = '';
  var medial = '';
  var finale = '';

  var initialOffset = -1;
  var medialOffset = -1;
  var finaleOffset = -1;

  if (onlyInitialKoreanRegex.hasMatch(char)) {
    initial = char;
    initialOffset = INITIALS.indexOf(initial);
  } else if (completedKoreanRegex.hasMatch(char)) {
    var temp = char.runes.first - BASE;
    finaleOffset = temp % FINALES.length;
    medialOffset = ((temp - finaleOffset) ~/ FINALES.length) % MEDIALS.length;
    initialOffset = ((temp - finaleOffset) ~/ FINALES.length - medialOffset) ~/
        MEDIALS.length;
    initial = INITIALS[initialOffset];
    medial = MEDIALS[medialOffset];
    finale = FINALES[finaleOffset];
  }

  return PhonemesResult(
      initial: initial,
      initialOffset: initialOffset,
      medial: medial,
      medialOffset: medialOffset,
      finale: finale,
      finaleOffset: finaleOffset);
}
