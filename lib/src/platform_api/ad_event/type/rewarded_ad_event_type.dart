enum RewardedAdEventType {
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
