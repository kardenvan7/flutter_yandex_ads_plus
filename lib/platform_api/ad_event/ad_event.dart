class AdEvent {
  const AdEvent({
    required this.viewUid,
    required this.type,
    this.parameters,
  });

  final String viewUid;
  final String type;
  final Map? parameters;

  factory AdEvent.fromJson(Map<String, dynamic> json) {
    return AdEvent(
      viewUid: json['view_uid'] as String,
      type: json['type'] as String,
      parameters: json['parameters'] as Map?,
    );
  }
}
