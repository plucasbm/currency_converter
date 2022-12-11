import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String prefix;
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.prefix,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
            controller: controller,
            decoration: InputDecoration(
              label: Text(
                label,
                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 25,
                ),
              ),
              prefix: Text(
                prefix,
                style: const TextStyle(
                  color: Colors.amber,
                ),
              ),
            ),
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 25,
            ),
            keyboardType: TextInputType.number,
            onChanged: onChanged,
      );
  }
}
