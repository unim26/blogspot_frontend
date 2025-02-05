import 'package:flutter/material.dart';

Widget myListTile({
  required String title,
  IconData? suffixIcon,
  required void Function()? onTap,
  required double height,
  bool alert = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: height * .08,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: alert ? Colors.red.shade300 : Colors.blue.shade100,
        border: Border.all(
          color: Colors.grey,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //title
          Text(
            title,
            style: TextStyle(
              fontSize: height * .035,
              fontWeight: FontWeight.bold,
            ),
          ),

          //suffix icon
          suffixIcon == null
              ? Container()
              : Icon(
                  suffixIcon,
                  size: 30,
                ),
        ],
      ),
    ),
  );
}
