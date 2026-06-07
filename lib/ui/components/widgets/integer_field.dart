import 'package:flutter/material.dart';

class IntegerField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData icon;
  final Function(String) onChanged;

  const IntegerField({
    super.key,
    required this.title,
    required this.controller,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: title,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
