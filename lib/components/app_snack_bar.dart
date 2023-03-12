import 'package:flutter/material.dart';
import 'package:ppostman/components/app_text.dart';

void showAppSnackBar(
  BuildContext context,
  String text, {
  Color? textColor,
  Color? color,
}) {
  final snackBar = SnackBar(
      padding: const EdgeInsets.only(top: 8, bottom: 0, left: 5, right: 5),
      duration: const Duration(seconds: 1),
      backgroundColor: color,
      content: AppText(
        color: textColor,
        maxLine: 3,
        fontSize: 18,
        textAlign: TextAlign.center,
        text: text,
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
