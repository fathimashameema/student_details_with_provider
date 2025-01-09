import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchFormField extends StatelessWidget {
  const CustomSearchFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20,
      ),
      child: CupertinoSearchTextField(
        style: const TextStyle(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: Icon(
          Icons.clear_rounded,
          color: Colors.grey,
        ),
      ),
    );
  }
}
