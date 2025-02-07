import 'package:blogspot/core/utils/widgests/my_button.dart';
import 'package:blogspot/core/utils/widgests/my_loading_indicator.dart';
import 'package:blogspot/core/utils/widgests/my_snack_bar.dart';
import 'package:blogspot/core/utils/widgests/my_text_field.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/otp_bloc/otp_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/otp_bloc/otp_event.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/otp_bloc/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<OtpBloc, OtpState>(
        //ui builder
        builder: (context, state) {
          //if state will be loadingstate then show loading indicator
          if (state is OtpLoadingState) {
            //show loading
            return Center(child: myLoadingIndicator(),);
          }

          //if state is not loading state then show page widget
          else {
            return Padding(
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
                    keyboardType: TextInputType.emailAddress,
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
                    onPressed: () {
                      context.read<OtpBloc>().add(
                            SendOtpEvent(email: emailController.text),
                          );
                    },
                  ),

                  //text button ---> back to login
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, 'loginPage'),
                    child: Text(
                      "Back to LogIn",
                      style: TextStyle(
                        fontSize: sHeight * .022,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },

        //listeners
        listener: (context, state) {
          //if state is otpsentfail state
          if (state is OtpFailedState) {
            emailController.clear();

            //show error message
            mySnacBar(
              context,
              color: Colors.red,
              message: state.message,
            );
          }

          //if otpsentsuccess state
          if (state is OtpSentState) {
            //show message that otp sent successfully to their email
            mySnacBar(
              context,
              color: Colors.green,
              message: 'Otp sent successfullt to ${emailController.text}',
            );

            //navigete to otp verification page for verification of otp
            Navigator.pushReplacementNamed(
              context,
              'otpVerificationPage',
              arguments: {
                'routeName': 'changePasswordPage',
                'email': emailController.text,
              },
            );
          }
        },
      ),
    );
  }
}
