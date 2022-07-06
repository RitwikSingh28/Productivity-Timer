// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback callback;

  const ProductivityButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.size,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      // ignore: sort_child_properties_last
      child: Text(
        this.text,
        style: const TextStyle(color: Colors.white),
      ),
      color: this.color,
      onPressed: this.callback,
      minWidth: this.size,
    );
  }
}

class SettingsButton extends StatelessWidget {
  final Color color;
  final int value;
  final String text;

  const SettingsButton({
    Key? key,
    required this.color,
    required this.value,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      // ignore: sort_child_properties_last, avoid_returning_null_for_void
      onPressed: () => null,
      color: this.color,
      child: Text(
        this.text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
