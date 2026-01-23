import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';

class ArabicTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;

  const ArabicTextWidget({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.right,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? AppTextStyles.arabicLarge,
      textAlign: textAlign,
      textDirection: TextDirection.rtl,
    );
  }
}
