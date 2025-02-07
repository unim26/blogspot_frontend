import 'package:blogspot/core/utils/methods/validator.dart';
import 'package:blogspot/core/utils/widgests/my_button.dart';
import 'package:blogspot/core/utils/widgests/my_snack_bar.dart';
import 'package:blogspot/core/utils/widgests/my_text_field.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/password_bloc/password_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/password_bloc/password_event.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/password_bloc/password_state.dart';
import 'package:blogspot/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key, required this.userEmail});

  //user email
  final String userEmail;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<PasswordBloc, PasswordState>(
        listener: (context, state) {

          //if state is error state
          if (state is PasswordFailToForgotState) {
            //show error message
            mySnacBar(
              context,
              color: Colors.red,
              message: state.message,
            );
          }

          //if state is success state
          if (state is PasswordForgotedState) {
            //show message
            mySnacBar(
              context,
              color: Colors.green,
              message:
                  'Your password has been updated! Please log in with your new credentials.',
            );

            //navigate to login page
            Navigator.pushNamedAndRemoveUntil(
                context, 'loginPage', (route) => route.isFirst);
          }
        },
        builder: (context, state) {

          //if state is loading state
          if (state is PasswordLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //if state is not loading state
          else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
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
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "************",
                      labelText: "Enter your new password",
                      prefixIcon: Icons.lock,
                      validator: (val) =>
                          locator<Validator>().validatePassword(val!),
                    ),

                    //text field ------> confirm password

                    myTextField(
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "*********",
                        labelText: "confirm your new password",
                        prefixIcon: Icons.lock,
                        validator: (val) {
                          if (val != passwordController.text) {
                            return "Password does not matched";
                          } else {
                            return null;
                          }
                        }),

                    //space
                    SizedBox(
                      height: sHeight * .02,
                    ),

                    //button -----> send otp
                    myButton(
                      bName: "Update Password",
                      onPressed: () {
                        ///validate form
                        if (_formKey.currentState!.validate()) {
                          //callling forot password function
                          context.read<PasswordBloc>().add(
                                ForgotPasswordEvent(
                                  email: userEmail,
                                  password: passwordController.text,
                                ),
                              );
                        } else {
                          //show error message
                          mySnacBar(
                            context,
                            color: Colors.red,
                            message: 'Password is required',
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
