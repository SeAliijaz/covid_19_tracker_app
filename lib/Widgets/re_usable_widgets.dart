import 'package:flutter/material.dart';

class ReUsableWidgets {
  static Widget reUsableRow(
    String title,
    String value,
  ) {
    return ListTile(title: Text(title), trailing: Text(value));
  }
}
