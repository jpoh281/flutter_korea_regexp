String reRegExpChar = '[\\^\$.*+?()[\]{}|]';
RegExp reHasRegExpChar = RegExp(reRegExpChar);

escapeRegExp(String string) {
  return string.isNotEmpty && reHasRegExpChar.hasMatch(string)
      ? string.replaceAll(reRegExpChar, '\\\$&')
      : string;
}
