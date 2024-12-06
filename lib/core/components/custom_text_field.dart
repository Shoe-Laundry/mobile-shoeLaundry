import 'package:shoelaundry/core/constants/colors.dart';
import 'package:flutter/material.dart';

import 'spaces.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String value)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool showLabel;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.showLabel = true,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(12.0),
        ],
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            hintText: label,
          ),
        ),
      ],
    );
  }
}

class CustomTextFieldContainer extends StatelessWidget {
  final String title;
  final bool? enabled;
  final String? hintText;

  final TextEditingController? controller;

  const CustomTextFieldContainer({
    Key? key,
    required this.title,
    this.controller,
    this.enabled,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: AppColors.black),
        ),
        const SizedBox(
          height: 3,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: AppColors.disabled2),
            color: enabled != null && enabled == false
                ? AppColors.card // Warna abu-abu jika dinonaktifkan
                : null, // Biarkan kosong jika diaktifkan
          ),
          child: TextField(
            controller: controller,
            autocorrect: false,
            enabled: enabled,
            style: TextStyle(fontSize: 12, color: AppColors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
              hintText: hintText,
              hintStyle: TextStyle(color: AppColors.black),
            ),
          ),
        ),
      ],
    );
  }
}
