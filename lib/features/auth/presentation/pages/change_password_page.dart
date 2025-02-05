import 'package:blogspot/core/utils/widgests/my_button.dart';
import 'package:blogspot/core/utils/widgests/my_text_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //app name
            Center(
              child: Text(
                "BlogSpot",
                style: TextStyle(
                  fontSize: sHeight * .04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //space
            SizedBox(
              height: sHeight * .03,
            ),

            //info text
            Text(
              "Update Your Password \nCreate a strong password to protect your account.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: sHeight * .025,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
            //space
            SizedBox(
              height: sHeight * .01,
            ),

            //text field ------> password

            myTextField(
              controller: passwordController,
              hintText: "************",
              labelText: "Enter your new password",
              prefixIcon: Icons.lock,
            ),

            //text field ------> confirm password

            myTextField(
              controller: confirmPasswordController,
              hintText: "*********",
              labelText: "confirm your new password",
              prefixIcon: Icons.lock,
            ),

            //space
            SizedBox(
              height: sHeight * .02,
            ),

            //button -----> send otp
            myButton(
              bName: "Update Password",
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, 'loginPage', (route) => false),
            ),

            //text button ---> resend otp
            TextButton(
              onPressed: () {},
              child: Text(
                "Resend OTP? 00:00",
                style: TextStyle(
                  fontSize: sHeight * .022,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
