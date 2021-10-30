import 'package:korea_regexp/constant.dart';
import 'package:korea_regexp/get_phonemes.dart';
import 'package:korea_regexp/models/phonemes_result.dart';


explode(String text, {bool grouped = false}) {
  List<List<String>> accum = [];
  text.split('').forEach((char) {
    PhonemesResult phonemesResult = getPhonemes(char);
    List<String> tempAccum = [];
    // 초성 중성 종성 중 하나라도 비는게 없는 경우
    if(phonemesResult.initialOffset != -1 ||
            phonemesResult.medialOffset != -1 ||
            phonemesResult.finaleOffset != -1
    ){
      tempAccum.add(phonemesResult.initial);
      (MIXED[phonemesResult.medial] != null &&
          PRESENT_ON_KEYBOARD.indexOf(phonemesResult.medial) != -1)
          ? MIXED[phonemesResult.medial]!.forEach((element) =>tempAccum.add(element))
          : tempAccum.add(phonemesResult.medial);
      (MIXED[phonemesResult.finale] != null &&
          PRESENT_ON_KEYBOARD.indexOf(phonemesResult.finale) == -1)
          ? MIXED[phonemesResult.finale]!.forEach((element) =>tempAccum.add(element))
          : tempAccum.add(phonemesResult.finale);

      tempAccum = tempAccum.where((element) => element != '').toList();
    }else{
      tempAccum.add(char);
    }
      accum.add(tempAccum);
  });

  return grouped ? accum : accum.expand((element) => element).toList();
}