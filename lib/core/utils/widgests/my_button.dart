import 'package:flutter/material.dart';

Widget myButton({
  required String bName,
  required void Function()? onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 172, 47),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          bName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}
