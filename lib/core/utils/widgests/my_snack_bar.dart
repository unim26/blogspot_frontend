import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mySnacBar(
  BuildContext context, {
  String? message,
  DioException? error,
  Color? color,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message ?? error!.message!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ),
  );
}
