import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension BuildContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}