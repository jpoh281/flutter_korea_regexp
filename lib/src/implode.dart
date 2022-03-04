import 'package:collection/collection.dart' show IterableNullableExtension;
import 'package:korea_regexp/src/constant.dart';

final complexDict = MIXED.map((k, v) => MapEntry(v.join(''), k));

// TODO(viiviii): 파라미터로 string[]이 오는 경우
String implode(String input) {
  final chars = <String>[];

  /// 인접한 모음을 하나의 복합 모음으로 합친다.
  input.split('').forEachWithIndex((e, i, arr) {
    if (chars.length > 0 &&
        MEDIALS.indexOf(arr[i - 1]) != -1 &&
        MEDIALS.indexOf(e) != -1 &&
        complexDict['${arr[i - 1]}$e'] != null) {
      chars[chars.length - 1] = complexDict['${arr[i - 1]}$e']!;
    } else {
      chars.add(e);
    }
  });

  _Group cursor = _Group.empty();
  final items = [cursor];

  /// 모음으로 시작하는 그룹들을 만든다. (grouped로 넘어온 항목들은 유지)
  chars.forEach((e) {
    if (MEDIALS.indexOf(e) != -1) {
      cursor = _Group.fromMedial(e);
      items.add(cursor);
    } else {
      cursor.finales.add(e);
    }
  });

  /// 각 그룹을 순회하면서 복합자음을 정리하고, 앞 그룹에서 종성으로 사용하고 남은 자음들을 초성으로 가져온다.
  items.forEachWithIndex((curr, i, arr) {
    if (i > 0) {
      final prev = arr[i - 1];
      if (prev.medial == null || prev.finales.length == 1) {
        curr.initials = prev.finales;
        prev.finales = [];
      } else {
        final finale = prev.finales.isNotEmpty ? prev.finales.first : null;
        final initials = prev.finales.skip(1).toList();
        curr.initials = initials;
        prev.finales = finale != null ? [finale] : [];
      }
      if (curr.finales.length > 2 ||
          (i == items.length - 1 && curr.finales.length > 1)) {
        final a = curr.finales.first;
        final b = curr.finales.elementAt(1);
        final rest = curr.finales.skip(2);
        final complex = complexDict['$a$b'];
        if (complex != null) {
          curr.finales = [complex, ...rest];
        }
      }
    }
  });

  /// 각 글자에 해당하는 블록 단위로 나눈 후 조합한다.
  final List<List<String>> groups = [];
  items.forEach((e) {
    final initials = e.initials;
    final medial = e.medial;
    final finales = e.finales;

    final List<String> pre = List.of(initials);
    final String? initial = pre.isNotEmpty ? pre.removeLast() : null;
    String? finale = finales.isNotEmpty ? finales.first : null;
    List<String?> post = finales.skip(1).toList();

    if (finale == null || FINALES.indexOf(finale) == -1) {
      post = [finale, ...post];
      finale = '';
    }
    pre.whereNotNull().forEach((e) => groups.add([e]));
    groups.add([initial, medial, finale].whereNotNull().toList());
    post.whereNotNull().forEach((e) => groups.add([e]));
  });

  return groups.map(assemble).join('');
}

String assemble(List<String> arr) {
  final startIndex = arr.indexWhere((e) => MEDIALS.indexOf(e) != -1);
  final endIndex =
      startIndex != -1 && MEDIALS.indexOf(arr[startIndex + 1]) != -1
          ? startIndex + 1
          : startIndex;

  // TODO(viiviii)
  if (startIndex == -1 || endIndex == -1) {
    return arr.first;
  }

  String initial = arr.sublist(0, startIndex).join('');
  String medial = arr.sublist(startIndex, endIndex + 1).join('');
  String finale = arr.sublist(endIndex + 1).join('');

  var initialOffset = INITIALS.indexOf(complexDict[initial] ?? initial);
  var medialOffset = MEDIALS.indexOf(complexDict[medial] ?? medial);
  var finaleOffset = FINALES.indexOf(complexDict[finale] ?? finale);

  if (initialOffset != -1 && medialOffset != -1) {
    return String.fromCharCode(BASE +
        initialOffset * (MEDIALS.length * FINALES.length) +
        medialOffset * FINALES.length +
        finaleOffset);
  }

  return arr.join('');
}

class _Group {
  List<String> initials = [];
  final String? medial;
  List<String> finales = [];

  _Group.empty() : medial = null;

  _Group.fromMedial(this.medial);

  @override
  String toString() => '$runtimeType($initials, $medial, $finales)';
}

extension _<E> on List<E> {
  void forEachWithIndex(void action(E element, int index, List<E> array)) {
    final array = List<E>.unmodifiable(this);
    for (int index = 0; index < length; index++) {
      var element = this[index];
      action(element, index, array);
    }
  }
}
