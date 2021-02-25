
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Utility {
  static customToast(BuildContext context, {@required String message, Color color}) {
    return showToast(message,
          context: context,
          backgroundColor: color ?? Colors.redAccent,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          startOffset: Offset(0.0, 3.0),
          reverseEndOffset: Offset(0.0, 3.0),
          position: StyledToastPosition.bottom,
          duration: Duration(seconds: 4),
          animDuration: Duration(seconds: 1),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);
  }
}