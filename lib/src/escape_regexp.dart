String reRegExpChar = r'[\\^\$.*+?\(\)\[\]\{\}|]';
RegExp reHasRegExpChar = RegExp(reRegExpChar);

escapeRegExp(String string) {
  return string.isNotEmpty && reHasRegExpChar.hasMatch(string)
      ? string.replaceAllMapped(
          reHasRegExpChar, (match) => '\\${match.group(0)}')
      : string;
}
