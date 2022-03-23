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
    initialOffset = initials.indexOf(initial);
  } else if (completedKoreanRegex.hasMatch(char)) {
    var temp = char.runes.first - base;
    finaleOffset = temp % finales.length;
    medialOffset = ((temp - finaleOffset) ~/ finales.length) % medials.length;
    initialOffset = ((temp - finaleOffset) ~/ finales.length - medialOffset) ~/
        medials.length;
    initial = initials[initialOffset];
    medial = medials[medialOffset];
    finale = finales[finaleOffset];
  }

  return PhonemesResult(
      initial: initial,
      initialOffset: initialOffset,
      medial: medial,
      medialOffset: medialOffset,
      finale: finale,
      finaleOffset: finaleOffset);
}
