enum RewardedAdEventType {
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
  onRewarded('onRewarded'),
  unknown('unknown');

  const RewardedAdEventType(this.value);

  factory RewardedAdEventType.fromString(String value) {
    return RewardedAdEventType.values.firstWhere(
      (element) => element.value == value,
      orElse: () => RewardedAdEventType.unknown,
    );
  }

  final String value;
}
