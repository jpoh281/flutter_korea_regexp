import 'package:flutter_test/flutter_test.dart';
import 'package:korea_regexp/src/implode.dart';

main() {
  group('implode', () {
    [
      ['ㄲㅏㄱㄷㅜㄱㅣ', '깍두기'],
      ['ㄲㅏㄱㄱㄷㅜㄱㅣ', '깎두기'],
      ['ㅂㅜㄹㄷㅏㄹㄱ', '불닭'],
      ['ㅂㅜㄹㄷㅏㄹㄱㅇㅡㄴ', '불닭은'],
      ['ㅇㅓㅂㅔㄴㅈㅕㅅㅡ ㅇㅐㄴㄷㅡㄱㅔㅇㅣㅁ', '어벤져스 앤드게임'],
    ].forEach((e) {
      final hints = e.first;
      final text = e.last;
      test('implode $hints → $text', () {
        expect(implode(hints), text);
      });
    });
  });

  group('mixMedial', () {
    test('ㅗㅏ -> ㅘ', () {
      expect(mixMedial(['ㅇ', 'ㅗ', 'ㅏ']), ['ㅇ', 'ㅘ']);
    });
    test('합칠 수 있는 복합 모음이 없는 경우 변경 사항이 없다', () {
      expect(mixMedial(['ㅇ', 'ㅣ', 'ㅇ']), ['ㅇ', 'ㅣ', 'ㅇ']);
    });
  });

  group('createGroupsByMedial', () {
    test('모음을 기준으로 `Groups`을 생성한다', () {
      final groups = createGroupsByMedial(['ㄱ', 'ㅡ', 'ㄹ', 'ㅐ']);

      final group1 = groups[0];
      expect(group1.finales, ['ㄱ']);

      final group2 = groups[1];
      expect(group2.medial, 'ㅡ');
      expect(group2.finales, ['ㄹ']);

      final group3 = groups[2];
      expect(group3.medial, 'ㅐ');
    });
  });

  group('앞 그룹에서 종성으로 사용하고 남은 자음들을 초성으로 가져오는 로직 테스트', () {
    test(
        '앞 그룹에 중성이 없는 경우,'
        '앞 그룹의 모든 종성을 현재 그룹의 초성으로 가져온다', () {
      //given
      final previous = Group.empty()..finales = ['ㄱ', 'ㄱ'];
      final current = Group.fromMedial('ㅏ');
      //when
      final groups =
          mixFinaleAndReplaceTheRemainingFinalesToInitials([previous, current]);
      //then
      final previousActual = groups.first;
      final currentActual = groups.last;
      expect(previousActual.finales, isEmpty);
      expect(currentActual.initials, ['ㄱ', 'ㄱ']);
    });
    test(
        '앞 그룹에 중성이 있고 종성은 1개인 경우,'
        '앞 그룹의 모든 종성을 현재 그룹의 초성으로 가져온다', () {
      //given
      final previous = Group.fromMedial('ㅗ')..finales = ['ㄱ'];
      final current = Group.fromMedial('ㅏ');
      //when
      final groups =
          mixFinaleAndReplaceTheRemainingFinalesToInitials([previous, current]);
      //then
      final previousActual = groups.first;
      final currentActual = groups.last;
      expect(previousActual.finales, isEmpty);
      expect(currentActual.initials, ['ㄱ']);
    });
    test(
        '앞 그룹에 중성이 있고 종성이 여러 개인 경우,'
        '앞 그룹의 종성을 1개만 남기고 모두 현재 그룹의 초성으로 가져온다', () {
      //given
      final previous = Group.fromMedial('ㅗ')..finales = ['ㄱ', 'ㄴ', 'ㄷ'];
      final current = Group.fromMedial('ㅏ');
      //when
      final groups =
          mixFinaleAndReplaceTheRemainingFinalesToInitials([previous, current]);
      //then
      final previousActual = groups.first;
      final currentActual = groups.last;
      expect(previousActual.finales, ['ㄱ']);
      expect(currentActual.initials, ['ㄴ', 'ㄷ']);
    });
  });

  group('복합자음 정리 로직 테스트', () {
    test('현재 그룹의 종성이 3개 이상이면 복합자음을 정리한다', () {
      //given
      final previous = Group.empty();
      final current = Group.fromMedial('ㅏ')..finales = ['ㄱ', 'ㄱ', 'ㄱ'];
      //when
      final groups =
          mixFinaleAndReplaceTheRemainingFinalesToInitials([previous, current]);
      //then
      expect(groups.last.finales, ['ㄲ', 'ㄱ']);
    });
    test('현재 그룹이 리스트의 마지막 요소이면 종성이 2개 이상일 때 복합자음을 정리한다', () {
      //given
      final previous = Group.empty();
      final current = Group.fromMedial('ㅏ')..finales = ['ㄱ', 'ㄱ'];
      //when
      final groups =
          mixFinaleAndReplaceTheRemainingFinalesToInitials([previous, current]);
      //then
      expect(current, equals(groups.last));
      expect(groups.last.finales, ['ㄲ']);
    });
    test('복합자음이 유효하지 않으면 정리되지 않는다', () {
      //given
      final previous = Group.empty();
      final current = Group.fromMedial('ㅏ')..finales = ['ㅋ', 'ㅎ'];
      //when
      final groups =
          mixFinaleAndReplaceTheRemainingFinalesToInitials([previous, current]);
      //then
      expect(groups.last.finales, ['ㅋ', 'ㅎ']);
    });
  });

  group('divideByBlock', () {
    test('`Group initials`의 마지막 글자만 초성으로 사용된다', () {
      final group = Group.fromMedial('ㅗ')
        ..initials = ['ㅇ', 'ㄲ']
        ..finales = ['ㅊ'];
      expect(divideByBlock(group), [
        ['ㅇ'],
        ['ㄲ', 'ㅗ', 'ㅊ']
      ]);
    });
    test('`Group finales`의 첫번째 글자만 종성으로 사용된다', () {
      final group = Group.fromMedial('ㅗ')
        ..initials = ['ㄲ']
        ..finales = ['ㅊ', 'ㅇ'];
      expect(divideByBlock(group), [
        ['ㄲ', 'ㅗ', 'ㅊ'],
        ['ㅇ']
      ]);
    });
    test('`Group finales`의 첫번째 글자가 유효하지 않으면 종성으로 사용되지 않는다', () {
      final group = Group.fromMedial('ㅗ')
        ..initials = ['ㄲ']
        ..finales = ['s', 'ㅊ'];
      expect(divideByBlock(group), [
        ['ㄲ', 'ㅗ'],
        ['s'],
        ['ㅊ']
      ]);
    });
    test('초성은 유효성 검사를 하지 않고 사용된다', () {
      final group = Group.fromMedial('ㅗ')
        ..initials = ['ㄲ', 's']
        ..finales = ['ㅊ'];
      expect(divideByBlock(group), [
        ['ㄲ'],
        ['s', 'ㅗ', 'ㅊ']
      ]);
    });
    test('빈 값인 경우 빈 배열을 리턴한다', () {
      final group = Group.empty();
      expect(divideByBlock(group), [[]]);
    });
    test('빈 문자열인 경우 빈 배열을 리턴한다', () {
      final group = Group.empty()
        ..initials = ['']
        ..finales = [''];
      expect(divideByBlock(group), [[]]);
    });
  });

  group('assemble', () {
    test('올바른 음절 형식인 경우 합친 하나의 음절을 리턴한다', () {
      expect(assemble(['ㄲ', 'ㅗ', 'ㅊ']), '꽃');
    });
    test('종성이 없는 경우 연결된 문자열을 리턴한다', () {
      expect(assemble(['ㅇ', 'ㅇ', 'ㅇ']), 'ㅇㅇㅇ');
    });
    test('올바른 음절 형식이 아닌 경우 연결된 문자열을 리턴한다', () {
      expect(assemble(['ㄽ', 'ㅗ', 'ㅇ']), 'ㄽㅗㅇ');
    });
  });

  group('createSyllableFormByMedial', () {
    test('문자열에서 초성, 중성, 종성을 분리한다', () {
      final block = createSyllableFormByMedial(['ㄲ', 'ㅗ', 'ㅊ']);
      expect(block.initial, 'ㄲ');
      expect(block.medial, 'ㅗ');
      expect(block.finale, 'ㅊ');
    });
    test('중성이 2글자 이상이어도 2글자만 중성으로 분리된다', () {
      final block = createSyllableFormByMedial(['ㅇ', 'ㅜ', 'ㅣ', 'ㅜ', 'ㅣ']);
      expect(block.initial, 'ㅇ');
      expect(block.medial, 'ㅜㅣ');
      expect(block.finale, 'ㅜㅣ');
    });
  });

  group('Composition', () {
    test('올바른 음절 형식인경우 toSyllable()는 하나의 한글 음절을 리턴한다', () {
      final form = SyllableForm('ㄲ', 'ㅗ', 'ㅊ');
      expect(Composition.from(form).toSyllable(), '꽃');
    });
    test('초성이 유효하지 않으면 isValid는 false를 리턴한다', () {
      final form = SyllableForm('ㄽ', 'ㅗ', 'ㅇ');
      expect(Composition.from(form).isValid, false);
    });
    test('중성이 유효하지 않으면 isValid는 false를 리턴한다', () {
      final form = SyllableForm('ㄹ', 'ㄹ', 'ㅇ');
      expect(Composition.from(form).isValid, false);
    });
    test('종성은 isValid에서 유효성 검사를 하지 않는다', () {
      final form = SyllableForm('ㄹ', 'ㅗ', 'ㅗ');
      expect(Composition.from(form).isValid, isNot(false));
    });
    test('복합 초성를 한번 더 합친다', () {
      final form = SyllableForm('ㄱㄱ', 'ㅗ', 'ㅊ');
      expect(Composition.from(form).toSyllable(), '꽃');
    });
    test('복합 중성를 한번 더 합친다', () {
      final form = SyllableForm('ㅇ', 'ㅜㅣ', '');
      expect(Composition.from(form).toSyllable(), '위');
    });
    test('복합 종성를 한번 더 합친다', () {
      final form = SyllableForm('ㅇ', 'ㅣ', 'ㅅㅅ');
      expect(Composition.from(form).toSyllable(), '있');
    });
    test('하지만 초성에서 ㄸ, ㅃ와 같은 복합 자모는 합치지 못한다', () {
      final form = SyllableForm('ㄷㄷ', 'ㅣ', '');
      expect(Composition.from(form).toSyllable(), isNot('띠'));
    });
  });
}
