import 'package:flutter/material.dart';

class MoneyField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData icon;
  final Function(String) onChanged;

  const MoneyField({
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
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: title,
        prefixText: 'R\$ ',
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}