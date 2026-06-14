import 'package:flutter/material.dart';

class WeightField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData icon;
  final Function(String) onChanged;

  const WeightField({
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
      cursorColor: Color.fromARGB(200, 175, 135, 100),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: title,
        suffixText: 'kg',
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Color.fromARGB(200, 175, 135, 100),
          )
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        floatingLabelStyle: TextStyle(
          color: Color.fromARGB(255, 75, 37, 1),
          fontWeight: FontWeight.bold
        )
      ),
    );
  }
}