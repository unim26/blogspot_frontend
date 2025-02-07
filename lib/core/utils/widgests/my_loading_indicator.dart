import 'package:flutter/material.dart';

Widget myLoadingIndicator() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Text(
          "Loading, hang tight!",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}
