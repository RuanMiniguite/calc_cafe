import 'package:flutter/material.dart';

class PercentField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String title;

  const PercentField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: title,
        suffixText: "%",
        prefixIcon: const Icon(Icons.percent),
      ),
    );
  }
}