import 'package:blogspot/core/utils/widgests/my_button.dart';
import 'package:blogspot/core/utils/widgests/my_text_field.dart';
import 'package:flutter/material.dart';

class VerifyOtpPage extends StatelessWidget {
  VerifyOtpPage({super.key, required this.routeName});

  final String routeName;

  final TextEditingController otpController = TextEditingController();

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
              "Verify your account \nEnter the OTP send to your registered email.",
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
              controller: otpController,
              hintText: "OTP",
              labelText: "Enter your OTP",
              prefixIcon: Icons.pin,
            ),

            //space
            SizedBox(
              height: sHeight * .02,
            ),

            //button -----> verify otp
            myButton(
              bName: "verify OTP",
              onPressed: () {
                Navigator.pushReplacementNamed(context, routeName);
              },
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
