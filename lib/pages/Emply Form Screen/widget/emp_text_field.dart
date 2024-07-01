// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EmpTextField extends StatelessWidget {
  final String text;
  final bool isNumKey;
  final TextEditingController controller;
  const EmpTextField({
    super.key,
    required this.text,
    required this.isNumKey,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              height: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: controller,
            maxLength: isNumKey ? 2 : 100,
            keyboardType: isNumKey ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
