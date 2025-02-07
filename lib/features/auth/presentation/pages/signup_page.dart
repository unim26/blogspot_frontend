import 'package:blogspot/core/utils/methods/validator.dart';
import 'package:blogspot/core/utils/widgests/my_button.dart';
import 'package:blogspot/core/utils/widgests/my_loading_indicator.dart';
import 'package:blogspot/core/utils/widgests/my_snack_bar.dart';
import 'package:blogspot/core/utils/widgests/my_text_field.dart';
import 'package:blogspot/features/auth/presentation/blocs/obscure_password/obscure_password_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/obscure_password/obscure_password_state.dart';
import 'package:blogspot/features/auth/presentation/blocs/obscure_password/obscure_pasword_event.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/local/local_user_cubit.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_event.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_state.dart';
import 'package:blogspot/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//form key
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  //boolean for comfirm password
  final ValueNotifier<bool> isConfirmObscure = ValueNotifier<bool>(true);

  //textfields cotroller
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: BlocConsumer<RemoteUserBloc, RemoteUserState>(
      listener: (context, state) {
        //if state is error state
        if (state is RemoteUserErrorState) {
          //show error message
          mySnacBar(
            context,
            color: Colors.red,
            message: state.message,
          );
        }

        //if state is success state
        if (state is RemoteUserLoadedState) {
          //show success message
          mySnacBar(
            context,
            color: Colors.green,
            message: "Hooray! Your account has been created.",
          );

          print(
              "<=================================>user auth token${state.user!.token!}");

          //save user auth token
          context.read<LocalUserCubit>().saveUserAuthToken(state.user!.token!);

          //navigate to otp verification
          Navigator.pushReplacementNamed(
            context,
            'otpVerificationPage',
            arguments: {
              'routeName': 'homePage',
              'email': emailController.text,
            },
          );

          //clear all controller
          emailController.clear();
          fullNameController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        }
      },

      //<================================ui builder
      builder: (context, state) {
        //if state is loading state
        if (state is RemoteUserLoadingState) {
          //show loading indiactor
          return Center(
            child: myLoadingIndicator(),
          );
        } else {
          //page content
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
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
                      keyboardType: TextInputType.name,
                      labelText: "Enter your Full Name",
                      prefixIcon: Icons.person,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "fullName is required..!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    //text field ----> email
                    myTextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "example@gmail.com",
                        labelText: "Enter your email",
                        prefixIcon: Icons.email,
                        validator: (val) =>
                            locator<Validator>().validateEmail(val!)),

                    //text field ------> password
                    BlocBuilder<ObscurePasswordBloc, ObscurePasswordState>(
                      builder: (context, state) {
                        return myTextField(
                          controller: passwordController,
                          obscureText: state.isObsucre,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "*********",
                          labelText: "Enter your password",
                          prefixIcon: Icons.lock,
                          suffixIcon: state.isObsucre
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onPressed: () {
                            context.read<ObscurePasswordBloc>().add(
                                  ObscurePasswordToggleEvent(
                                    isObscure: !state.isObsucre,
                                  ),
                                );
                          },
                          validator: (val) =>
                              locator<Validator>().validatePassword(val!),
                        );
                      },
                    ),

                    //text field ------> confirm password
                    ValueListenableBuilder<bool>(
                      valueListenable: isConfirmObscure,
                      builder: (context, isObscure, child) {
                        return myTextField(
                          controller: confirmPasswordController,
                          obscureText: isObscure,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "*********",
                          labelText: "Confirm your new password",
                          prefixIcon: Icons.lock,
                          suffixIcon: isObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onPressed: () {
                            isConfirmObscure.value = !isConfirmObscure.value;
                          },
                          validator: (val) {
                            if (val != passwordController.text) {
                              return "Passwords do not match";
                            } else {
                              return null;
                            }
                          },
                        );
                      },
                    ),

                    //space
                    SizedBox(
                      height: sHeight * .02,
                    ),

                    //Button ------> signup
                    myButton(
                      bName: "SignUp",
                      onPressed: () {
                        //check if form is validated
                        if (_formKey.currentState!.validate()) {
                          context.read<RemoteUserBloc>().add(
                                RemoteUserRegisterEvent(
                                  fullName: fullNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        } else {
                          //show error message
                          mySnacBar(
                            context,
                            color: Colors.red,
                            message: "All fields are required.1",
                          );
                        }
                      },
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
                                color: Colors.black54,
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
      },
    ));
  }
}
