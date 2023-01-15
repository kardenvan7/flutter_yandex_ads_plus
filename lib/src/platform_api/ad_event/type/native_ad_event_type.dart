enum NativeAdEventType {
  onClose('onClose'),
  unknown('unknown');

  const NativeAdEventType(this.value);

  factory NativeAdEventType.fromString(String value) {
    return NativeAdEventType.values.firstWhere(
      (element) => element.value == value,
      orElse: () => NativeAdEventType.unknown,
    );
  }

  final String value;
}
