import 'package:blogspot/core/utils/widgests/my_button.dart';
import 'package:blogspot/core/utils/widgests/my_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;
    final double sWidth = MediaQuery.of(context).size.width;
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
              "Enter your email \nto recieve OTP",
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

            //text field ------> email

            myTextField(
              controller: emailController,
              hintText: "example@gmail.com",
              labelText: "Enter your email",
              prefixIcon: Icons.email,
            ),

            //space
            SizedBox(
              height: sHeight * .02,
            ),

            //button -----> send otp
            myButton(
              bName: "Send OTP",
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                'otpVerificationPage',
                arguments: {'changePasswordPage','Abhishek kumar'},
              
              ),
            ),

            //text button ---> back to login
            TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'loginPage'),
              child: Text(
                "Back to LogIn",
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
