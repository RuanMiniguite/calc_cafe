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
      cursorColor: Color.fromARGB(200, 175, 135, 100),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: title,
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
