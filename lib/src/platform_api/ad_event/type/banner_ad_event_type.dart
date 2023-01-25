enum BannerAdEventType {
  onAdLoaded('onAdLoaded'),
  onAdFailedToLoad('onAdFailedToLoad'),
  onImpression('onImpression'),
  onLeftApplication('onLeftApplication'),
  onReturnedToApplication('onReturnedToApplication'),
  willPresentScreen('willPresentScreen'),
  didDismissScreen('didDismissScreen'),
  onAdClicked('onAdClicked'),
  unknown('unknown');

  const BannerAdEventType(this.value);

  final String value;

  factory BannerAdEventType.fromString(String value) {
    return BannerAdEventType.values.firstWhere(
      (element) => element.value == value,
      orElse: () => BannerAdEventType.unknown,
    );
  }
}
