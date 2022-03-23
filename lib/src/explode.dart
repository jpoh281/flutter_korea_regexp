import 'package:korea_regexp/src/constant.dart';
import 'package:korea_regexp/src/get_phonemes.dart';
import 'package:korea_regexp/src/models/phonemes_result.dart';

explode(String text, {bool grouped = false}) {
  List<List<String>> accum = [];
  text.split('').forEach((char) {
    PhonemesResult phonemesResult = getPhonemes(char);
    List<String> tempAccum = [];
    // 초성 중성 종성 중 하나라도 비는게 없는 경우
    if (phonemesResult.initialOffset != -1 ||
        phonemesResult.medialOffset != -1 ||
        phonemesResult.finaleOffset != -1) {
      tempAccum.add(phonemesResult.initial);
      (mixed[phonemesResult.medial] != null &&
              presentOnKeyboard.contains(phonemesResult.medial))
          ? mixed[phonemesResult.medial]!
              .forEach((element) => tempAccum.add(element))
          : tempAccum.add(phonemesResult.medial);
      (mixed[phonemesResult.finale] != null &&
              !presentOnKeyboard.contains(phonemesResult.finale))
          ? mixed[phonemesResult.finale]!
              .forEach((element) => tempAccum.add(element))
          : tempAccum.add(phonemesResult.finale);

      tempAccum = tempAccum.where((element) => element != '').toList();
    } else {
      tempAccum.add(char);
    }
    accum.add(tempAccum);
  });

  return grouped ? accum : accum.expand((element) => element).toList();
}
