import 'package:flutter/material.dart';
import 'package:tmsmobile/utils/dimens.dart';

bool isTextWrapped({
  required String text,
  required double maxWidth,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: TextStyle(fontSize: kTextSmall)),
    textDirection: TextDirection.ltr, // Specify the text direction
  )..layout(maxWidth: maxWidth);

  // Get the number of lines rendered
  final int lineCount = textPainter.computeLineMetrics().length;

  // If there is more than one line, the text has wrapped
  return lineCount > 1;
}
