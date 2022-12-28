import 'package:flutter/foundation.dart';

import '../ad_event_listener.dart';

class BasicAdEventListener extends AdEventListener {
  const BasicAdEventListener({
    required this.viewUid,
    this.onAdLoaded,
    this.onAdFailedToLoad,
    this.onImpression,
    this.onAdClicked,
    this.onLeftApplication,
    this.onReturnedToApplication,
  });

  final String viewUid;

  final VoidCallback? onAdLoaded;
  final void Function(int code, String description)? onAdFailedToLoad;
  final void Function(String? impression)? onImpression;
  final VoidCallback? onAdClicked;
  final VoidCallback? onLeftApplication;
  final VoidCallback? onReturnedToApplication;
}
