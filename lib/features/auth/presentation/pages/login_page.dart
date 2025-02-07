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

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //textfields cotroller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: BlocConsumer<RemoteUserBloc, RemoteUserState>(
      //ui builder
      builder: (context, state) {
        //if state of context will be loading
        if (state is RemoteUserLoadingState) {

          //show loading indicator
          return Center(child: myLoadingIndicator(),);
        }

        //if state of context will be other than loading
        else {
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
                      height: sHeight * .25,
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
                      height: sHeight * .04,
                    ),

                    //welcome text
                    Text(
                      "Welcome back! \nReady to share your thoughts?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: sHeight * .025,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),

                    //space
                    SizedBox(
                      height: sHeight * .02,
                    ),

                    //text field ----> email
                    myTextField(
                      controller: emailController,
                      hintText: "example@gmail.com",
                      labelText: "Enter your email",
                      prefixIcon: Icons.email,
                      validator: (val) =>
                          locator<Validator>().validateEmail(val!),
                    ),

                    //text field ------> password
                    BlocBuilder<ObscurePasswordBloc, ObscurePasswordState>(
                      builder: (context, state) {
                        return myTextField(
                          obscureText: state.isObsucre,
                          controller: passwordController,
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

                    //text button  ------> forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //text button ----> forgot password
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, 'forgotPasswordPage'),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: sHeight * .022,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //space
                    SizedBox(
                      height: sHeight * .02,
                    ),

                    //Button ------> login
                    myButton(
                      bName: "LogIn",
                      onPressed: () {
                        //LOGIN METHOD

                        //check for validation
                        if (_formKey.currentState!.validate()) {
                          //calling login function
                          context.read<RemoteUserBloc>().add(
                                RemoteUserLoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
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
                          Navigator.pushReplacementNamed(context, 'signupPage'),
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            fontSize: sHeight * .02,
                            color: Colors.black54,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
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
      listener: (context, state) {
        //if state of context will be error state
        if (state is RemoteUserErrorState) {
          //show error message
          mySnacBar(
            context,
            color: Colors.red,
            message: state.message,
          );

          //clear controllers
          emailController.clear();
          passwordController.clear();
        }

        //if state is success state
        if (state is RemoteUserLoadedState) {
          //show success message
          mySnacBar(
            context,
            color: Colors.green,
            message: "You’ve successfully logged in. Let’s get started!",
          );

          //save user auth token
          context.read<LocalUserCubit>().saveUserAuthToken(state.user!.token!);

          //navigate to homepage
          Navigator.pushNamedAndRemoveUntil(
              context, 'homePage', (route) => route.isFirst);
        }
      },
    ));
  }
}
