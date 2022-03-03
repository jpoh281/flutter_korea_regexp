// import 'package:korea_regexp/constant.dart';
//
// Map complexDict = MIXED.entries.fold(
//     {},
//     (previousValue, element) =>
//         {...previousValue, element.value.join(''): element.key});
//
// assemble(List arr) {
//   var startIndex = arr.indexWhere((element) => MEDIALS.indexOf(element) != -1);
//   var endIndex = startIndex != -1 && MEDIALS.indexOf(arr[startIndex + 1]) != -1
//       ? startIndex + 1
//       : startIndex;
//
//   var initail = arr.sublist(0, startIndex).join('');
//   var medial = arr.sublist(startIndex, endIndex + 1).join('');
//   var finale = arr.sublist(endIndex + 1).join('');
//
//   var initialOffset = INITIALS.indexOf(complexDict[initail] ?? initail);
//   var medialOffset = MEDIALS.indexOf(complexDict[medial] ?? medial);
//   var finaleOffset = FINALES.indexOf(complexDict[finale] ?? finale);
//
//   if (initialOffset != -1 && medialOffset != -1) {
//     return String.fromCharCode(BASE +
//         initialOffset * (MEDIALS.length * FINALES.length) +
//         medialOffset * FINALES.length +
//         finaleOffset);
//   }
//   return arr.join('');
// }

//
// implode(dynamic input){
//   List<dynamic> chars = [];
//
//   (input.runtimeType == String ? (input as String).split('') : input as List).forEach((element) {
//     if(element.runtimeType == String && chars.length > 0 && MEDIALS.indexOf(element) != -1 && complexDict[])
//   });
// }