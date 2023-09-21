class RegExpOptions {
  final bool initialSearch;
  final bool startsWith;
  final bool endsWith;
  final bool ignoreSpace;
  final bool ignoreCase;
  final bool global;
  final bool fuzzy;
  final bool nonCaptureGroup;

  const RegExpOptions({
    this.initialSearch = false,
    this.startsWith = false,
    this.endsWith = false,
    this.ignoreSpace = false,
    this.ignoreCase = false,
    this.global = false,
    this.fuzzy = false,
    this.nonCaptureGroup = false,
  });
}
