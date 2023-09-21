import 'package:korea_regexp/src/constant.dart';
import 'package:korea_regexp/src/escape_regexp.dart';
import 'package:korea_regexp/src/get_phonemes.dart';
import 'package:korea_regexp/src/models/regexp_options.dart';

getInitialSearchRegExp(String initial, {bool allowOnlyInitial = false}) {
  var initialOffset = initials.indexOf(initial);
  if (initialOffset != -1) {
    var baseCode = initialOffset * medials.length * finales.length + base;
    return '[${allowOnlyInitial ? initial : ''}${String.fromCharCode(baseCode)}-${String.fromCharCode(baseCode + medials.length * finales.length - 1)}]';
  }
  return initial;
}

var fuzzy = '__${int.parse('fuzzy', radix: 36)}__';
var ignoreSpace = '__${int.parse('ignorespace', radix: 36)}__';

getRegExp(String search, RegExpOptions options) {
  List<String> frontChars = search.split('');
  String? lastChar = frontChars[frontChars.length - 1];
  String lastCharPattern = '';

  var phonemes = getPhonemes(lastChar);

  // 마지막 글자가 한글인 경우만 수행
  if (phonemes.initialOffset != -1) {
    frontChars = frontChars.sublist(0, frontChars.length - 1);

    var baseCode =
        phonemes.initialOffset * medials.length * finales.length + base;
    List<String> patterns = [];
    // 종성으로 끝나는 경우 ( 받침이 있는 경우)
    if (phonemes.finale != '') {
      patterns.add(lastChar);

      // 종성이 초성으로 사용 가능한 경우
      if (initials.contains(phonemes.finale)) {
        patterns.add(
            '${String.fromCharCode(baseCode + phonemes.medialOffset * finales.length)}${getInitialSearchRegExp(phonemes.finale)}');
      }
      if (mixed[phonemes.finale] != null) {
        patterns.add(
            '${String.fromCharCode((baseCode + phonemes.medialOffset * finales.length + finales.join('').indexOf(mixed[phonemes.finale]![0])) + 1)}${getInitialSearchRegExp(mixed[phonemes.finale]![1])}');
      }
    } else if (phonemes.medial != '') {
      int from, to;

      if (medialRange[phonemes.medial] != null) {
        from = baseCode +
            medials.join('').indexOf(medialRange[phonemes.medial]![0]) *
                finales.length;
        to = baseCode +
            medials.join('').indexOf(medialRange[phonemes.medial]![1]) *
                finales.length +
            finales.length -
            1;
      } else {
        from = baseCode + phonemes.medialOffset * finales.length;
        to = from + finales.length - 1;
      }
      patterns.add('[${String.fromCharCode(from)}-${String.fromCharCode(to)}]');
    } else if (phonemes.initial != '') {
      patterns.add(
          getInitialSearchRegExp(phonemes.initial, allowOnlyInitial: true));
    }
    lastCharPattern =
        patterns.length > 1 ? '(${patterns.join('|')})' : patterns[0];
  }

  var glue = options.fuzzy
      ? fuzzy
      : options.ignoreSpace
          ? ignoreSpace
          : '';
  var frontCharsPattern = options.initialSearch
      ? frontChars
          .map((char) => (RegExp('[ㄱ-ㅎ]').hasMatch(char)
              ? getInitialSearchRegExp(char, allowOnlyInitial: true)
              : escapeRegExp(char)))
          .join(glue)
      : escapeRegExp(frontChars.join(glue));
  var pattern = (options.startsWith ? '^' : '') +
      frontCharsPattern +
      glue +
      lastCharPattern +
      (options.endsWith ? '\$' : '');

  if (glue != '') {
    pattern = pattern
        .replaceAll(RegExp(fuzzy), '.*')
        .replaceAll(RegExp(ignoreSpace), '\s*');
  }
  return RegExp(pattern, caseSensitive: !options.ignoreCase);
}
