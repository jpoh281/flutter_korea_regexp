import 'package:korea_regexp/get_phonemes.dart';
import 'package:korea_regexp/models/phonemes_result.dart';

// 수정중

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
                '''([가-힣]['" ]{0,1})${element[0]}\\(${element[1]}\\)''',
            element[0],
            element[1]
          ],
          [
                '''([가-힣]['" ]{0,1})${element[1]}\\(${element[0]}\\)''',
            element[0],
            element[1]
          ]
        ]);

correctPostpositions(String text) {

  postPositions.forEach((element1) {
    RegExp exp = RegExp(element1[0]);
    print(exp);
    // print("변환 : ${text.replaceAll(exp, "XX")}");

    var match = (exp).allMatches(text).toList();

    match.forEach((element) {
      print("매치 텍스트 : ${element.group(0)} ${element.group(1)}");
     var newText = text.replaceAll(element.group(0)!, '${element.group(1)!.replaceAll('\\s', '')}${getPhonemes(element.group(1)!).finale.isNotEmpty ? element1[1] : element1[2]}');
      print(newText);
      print('${element.group(1)!.replaceAll('\\s', '')}${getPhonemes(element.group(1)!).finale.isNotEmpty?element1[1]:element1[2]}');
      print(element.group(1)!.split('').length);
    });
  });
    // text.replaceAll(, replace)
    
    // var aa = text.replaceAll(exp, 'replace');
    // print(aa);
  // });
  // text.replaceAllMapped(exp, (Match m) {
  //
  // });
 // String aa = postPositions.fold(text, (previousValue, element) => text.replaceAllMapped(element[0], (match) {
 //    return '${match[0]!.replaceAll('\\s+\$', '')}${getPhonemes(match[0]!).finale.isNotEmpty ? element[1] : element[2]}${match[1]}';
 //  }));
 // print(aa);

  return postPositions.fold(text, (previousValue, element) => text.replaceAllMapped(element[0], (Match match) {
    print("match : ${match.groupCount}");
    // print('testtest : ${match[0]!.replaceAll('\\s+\$', '')}${getPhonemes(match[0]!).finale.isNotEmpty ? element[1] : element[2]}${match[1]}');
   return '${match[0]!.replaceAll('\s+\$', '')}${getPhonemes(match[0]!).finale.isNotEmpty ? element[1] : element[2]}${match[1]}';
  }));

  // return postPositions.fold(
  //     text,
  //     (String prev, element) {
  //       // print((element[0] as RegExp).allMatches(text).length);
  //       RegExp exp = RegExp(element[0]);
  //       return text.replaceAllMapped(exp, Match m) {
  //        
  //       }
  //     });
}
