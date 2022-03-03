import 'package:korea_regexp/src/constant.dart';
import 'package:korea_regexp/src/escape_regexp.dart';
import 'package:korea_regexp/src/get_phonemes.dart';
import 'package:korea_regexp/src/models/regexp_options.dart';

getInitialSearchRegExp(String initial) {
  var initialOffset = INITIALS.indexOf(initial);
  if (initialOffset != -1) {
    var baseCode = initialOffset * MEDIALS.length * FINALES.length + BASE;
    return '[${String.fromCharCode(baseCode)}-${String.fromCharCode(baseCode + MEDIALS.length * FINALES.length - 1)}]';
  }
  return initial;
}

var FUZZY = '__${int.parse('fuzzy', radix: 36)}__';
var IGNORE_SPACE = '__${int.parse('ignorespace', radix: 36)}__';

getRegExp(String search, RegExpOptions options) {
  List<String> frontChars = search.split('');
  String? lastChar = frontChars[frontChars.length - 1];
  String lastCharPattern = '';

  var phonemes = getPhonemes(lastChar);

  // 마지막 글자가 한글인 경우만 수행
  if (phonemes.initialOffset != -1) {
    frontChars = frontChars.sublist(0, frontChars.length - 1);

    var baseCode =
        phonemes.initialOffset * MEDIALS.length * FINALES.length + BASE;
    List<String> patterns = [];
    // 종성으로 끝나는 경우 ( 받침이 있는 경우)
    if (phonemes.finale != '') {
      patterns.add(lastChar);

      // 종성이 초성으로 사용 가능한 경우
      if (INITIALS.contains(phonemes.finale)) {
        patterns.add(
            '${String.fromCharCode(baseCode + phonemes.medialOffset * FINALES.length)}${getInitialSearchRegExp(phonemes.finale)}');
      }
      if (MIXED[phonemes.finale] != null) {
        patterns.add(
            '${String.fromCharCode((baseCode + phonemes.medialOffset * FINALES.length + FINALES.join('').indexOf(MIXED[phonemes.finale]![0])) + 1)}${getInitialSearchRegExp(MIXED[phonemes.finale]![1])}');
      }
    } else if (phonemes.medial != '') {
      int from, to;

      if (MEDIAL_RANGE[phonemes.medial] != null) {
        from = baseCode +
            MEDIALS.join('').indexOf(MEDIAL_RANGE[phonemes.medial]![0]) *
                FINALES.length;
        to = baseCode +
            MEDIALS.join('').indexOf(MEDIAL_RANGE[phonemes.medial]![1]) *
                FINALES.length +
            FINALES.length -
            1;
      } else {
        from = baseCode + phonemes.medialOffset * FINALES.length;
        to = from + FINALES.length - 1;
      }
      patterns.add('[${String.fromCharCode(from)}-${String.fromCharCode(to)}]');
    } else if (phonemes.initial != '') {
      patterns.add(getInitialSearchRegExp(phonemes.initial));
    }
    lastCharPattern =
        patterns.length > 1 ? '(${patterns.join('|')})' : patterns[0];
  }
  var glue = options.fuzzy
      ? FUZZY
      : options.ignoreSpace
          ? IGNORE_SPACE
          : '';
  var frontCharsPattern = options.initialSearch
      ? frontChars
          .map((char) => (RegExp('[ㄱ-ㅎ]').hasMatch(char)
              ? getInitialSearchRegExp(char)
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
        .replaceAll(RegExp(FUZZY), '\.*')
        .replaceAll(RegExp(IGNORE_SPACE), '\s*');
  }
  return RegExp(pattern, caseSensitive: !options.ignoreCase);
}
