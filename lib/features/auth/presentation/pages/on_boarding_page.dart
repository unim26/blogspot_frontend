import 'package:blogspot/core/utils/widgests/my_button.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;
    final double sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //space
            SizedBox(
              height: sHeight * .07,
            ),
            //image
            Center(
              child: Image.asset(
                "assets/images/onboardimage.png",
                height: sHeight * .5,
                width: sWidth * .8,
              ),
            ),

            //text ------> heading
            Text(
              "Share your thoughts",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: sHeight * .04,
                fontWeight: FontWeight.bold,
              ),
            ),

            //text ------> discription
            Text(
              "Express your thoughts, connect with readers, and join a network of passionate bloggers.",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: sHeight * .023,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),

            //space
            SizedBox(
              height: sHeight * .07,
            ),

            //button
            myButton(
              bName: "Strat writing",
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'loginPage'),
            )
          ],
        ),
      ),
    );
  }
}
