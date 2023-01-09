enum InterstitialAdEventType {
  onAdShown('onAdShown'),
  onAdDismissed('onAdDismissed'),
  unknown('unknown');

  const InterstitialAdEventType(this.value);

  factory InterstitialAdEventType.fromString(String value) {
    return InterstitialAdEventType.values.firstWhere(
      (element) => element.value == value,
      orElse: () => InterstitialAdEventType.unknown,
    );
  }

  final String value;
}
