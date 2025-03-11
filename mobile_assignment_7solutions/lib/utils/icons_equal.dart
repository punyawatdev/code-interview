import 'package:flutter/material.dart';

bool areIconsEqual(IconData icon1, IconData icon2) {
  return icon1.codePoint == icon2.codePoint;
}
