import 'package:flutter/material.dart';

class InfoRowSaca extends StatelessWidget {
  final String title;
  final String value;
  final String value2;

  const InfoRowSaca({
    super.key,
    required this.title,
    required this.value,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                value2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
