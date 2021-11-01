class PhonemesResult {
  final String initial;
  final String medial;
  final String finale;
  final int initialOffset;
  final int medialOffset;
  final int finaleOffset;

  PhonemesResult(
      {this.initial = '',
      this.medial = '',
      this.finale = '',
      this.initialOffset = -1,
      this.medialOffset = -1,
      this.finaleOffset = -1});
}
