enum InterstitialAdEventType {
  onAdLoaded('onAdLoaded'),
  onAdFailedToLoad('onAdFailedToLoad'),
  onImpression('onImpression'),
  onLeftApplication('onLeftApplication'),
  onReturnedToApplication('onReturnedToApplication'),
  willPresentScreen('willPresentScreen'),
  didDismissScreen('didDismissScreen'),
  onAdClicked('onAdClicked'),
  onAdFailedToAppear('onAdFailedToAppear'),
  onAdShown('onAdShown'),
  onAdWillBeShown('onAdWillAppear'),
  onAdDismissed('onAdDismissed'),
  onAdWillBeDismissed('onAdWillDisappear'),
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
