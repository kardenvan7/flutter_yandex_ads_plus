enum BasicAdEventType {
  onAdLoaded('onAdLoaded'),
  onAdFailedToLoad('onAdFailedToLoad'),
  onImpression('onImpression'),
  onLeftApplication('onLeftApplication'),
  onReturnedToApplication('onReturnedToApplication'),
  willPresentScreen('willPresentScreen'),
  didDismissScreen('didDismissScreen'),
  onAdClicked('onAdClicked'),
  unknown('unknown');

  const BasicAdEventType(this.value);

  final String value;

  factory BasicAdEventType.fromString(String value) {
    return BasicAdEventType.values.firstWhere(
      (element) => element.value == value,
      orElse: () => BasicAdEventType.unknown,
    );
  }
}
