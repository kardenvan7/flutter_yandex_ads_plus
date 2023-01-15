class AdEvent {
  const AdEvent({
    required this.uid,
    required this.type,
    this.parameters,
  });

  final String uid;
  final String type;
  final Map? parameters;

  factory AdEvent.fromJson(Map<String, dynamic> json) {
    return AdEvent(
      uid: json['uid'] as String,
      type: json['type'] as String,
      parameters: json['parameters'] as Map?,
    );
  }
}
