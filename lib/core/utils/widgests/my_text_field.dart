import 'package:flutter/material.dart';

Widget myTextField({
  required TextEditingController controller,
  required String hintText,
  required String labelText,
  required IconData prefixIcon,
  void Function()? onPressed,
  IconData? suffixIcon,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
  bool obscureText = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: onPressed, icon: Icon(suffixIcon))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //temp
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2.5),
        ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(15),
        //   borderSide: const BorderSide(color: Colors.red, width: 1.5),
        // ),

        //float
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    ),
  );
}
