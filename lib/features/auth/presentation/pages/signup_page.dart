import 'package:blogspot/core/utils/widgests/my_button.dart';
import 'package:blogspot/core/utils/widgests/my_text_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  //textfields cotroller
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;
    final double sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //space
              SizedBox(
                height: sHeight * .2,
              ),

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
                height: sHeight * .025,
              ),

              //welcome text
              Text(
                "Sign up to connect, create, and inspire, \nFill in the details to unlock your creative space",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sHeight * .025,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),

              //text field ----> full name
              myTextField(
                controller: fullNameController,
                hintText: "your name",
                labelText: "Enter your Full Name",
                prefixIcon: Icons.person,
              ),
              //text field ----> email
              myTextField(
                controller: emailController,
                hintText: "example@gmail.com",
                labelText: "Enter your email",
                prefixIcon: Icons.email,
              ),

              //text field ------> password
              myTextField(
                controller: passwordController,
                hintText: "*********",
                labelText: "Enter your password",
                prefixIcon: Icons.lock,
              ),
              //text field ------> confirm password
              myTextField(
                controller: confirmPasswordController,
                hintText: "*********",
                labelText: "confirm your password",
                prefixIcon: Icons.lock,
              ),

              //space
              SizedBox(
                height: sHeight * .02,
              ),

              //Button ------> login
              myButton(
                bName: "SignUp",
                onPressed: () {},
              ),

              //space
              SizedBox(
                height: sHeight * .02,
              ),

              //text button -----> if user don't have account
              GestureDetector(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, 'loginPage'),
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                      fontSize: sHeight * .02,
                      color: Colors.black54,
                    ),
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          fontSize: sHeight * .02,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
