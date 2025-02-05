import 'package:blogspot/core/utils/widgests/my_snack_bar.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/local/local_user_cubit.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/methods/validator.dart';
import '../../../../core/utils/widgests/my_button.dart';
import '../../../../core/utils/widgests/my_text_field.dart';
import '../../../../injection_container.dart';
import '../blocs/obscure_password/obscure_password_bloc.dart';
import '../blocs/obscure_password/obscure_password_state.dart';
import '../blocs/obscure_password/obscure_pasword_event.dart';
import '../blocs/user/remote/user_bloc/remote_user_event.dart';

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

Widget buildLogInPageBody({
  double? sHeight,
  TextEditingController? emailController,
  TextEditingController? passwordController,
}) {
  return BlocConsumer<RemoteUserBloc, RemoteUserState>(
    listener: (context, state) {
      //is state is error state
      if (state is RemoteUserErrorState) {
        mySnacBar(
          context,
          color: Colors.red,
          message: state.message,
        );

        emailController!.clear();
        passwordController!.clear();
      } else if (state is RemoteUserLoadedState) {
        //save token to local storage
        context.read<LocalUserCubit>().saveUserAuthToken(state.user!.token!);

        //show snackbar
        mySnacBar(
          context,
          color: Colors.green,
          message: 'Successfully loggedIn',
        );

        //navigate to home page
        Navigator.pushReplacementNamed(context, 'home');
      }
    },
    builder: (context, state) {
      if (state is RemoteUserLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //app name
                      Center(
                        child: Text(
                          "BLOGSPOT",
                          style: TextStyle(
                            fontSize: sHeight! * .05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //space
                      SizedBox(
                        height: sHeight * .02,
                      ),

                      //infotext ----> Create an account
                      Text(
                        "LogIn to your account",
                        style: TextStyle(
                          fontSize: sHeight * .025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      //space
                      SizedBox(
                        height: sHeight * .01,
                      ),

                      //textformfield ----> email
                      myTextField(
                        controller: emailController!,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "example@gmail.com",
                        labelText: "enter your email",
                        prefixIcon: Icons.email,
                        validator: (val) =>
                            locator<Validator>().validateEmail(val!),
                      ),

                      //textformfield ----> password
                      BlocBuilder<ObscurePasswordBloc, ObscurePasswordState>(
                        buildWhen: (previous, current) => previous != current,
                        builder: (context, state) {
                          return myTextField(
                            controller: passwordController!,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: "***********",
                            labelText: "enter your password",
                            prefixIcon: Icons.password,
                            obscureText: state.isObsucre,
                            onPressed: () =>
                                context.read<ObscurePasswordBloc>().add(
                                      ObscurePasswordToggleEvent(
                                          isObscure: !state.isObsucre),
                                    ),
                            suffixIcon: state.isObsucre
                                ? Icons.visibility
                                : Icons.visibility_off,
                            validator: (val) =>
                                locator<Validator>().validatePassword(val!),
                          );
                        },
                      ),

                      //forgot password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              'forgotpasswordpage',
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: "forgot password ",
                                children: [
                                  TextSpan(
                                    text: "click here",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      //button ----> login to  account
                      myButton(
                        bName: "LogIn",
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            //log in user
                            context.read<RemoteUserBloc>().add(
                                  RemoteUserLoginEvent(
                                    email: emailController.text,
                                    password: passwordController!.text,
                                  ),
                                );
                          } else {
                            mySnacBar(
                              context,
                              color: Colors.red,
                              message: 'Please enter valid email and password',
                            );
                          }
                        },
                      ),

                      //Already have an account? ----> login account

                      GestureDetector(
                        onTap: () =>
                            Navigator.pushReplacementNamed(context, 'signIn'),
                        child: RichText(
                          text: TextSpan(
                            text: "Dont't have account? ",
                            children: [
                              TextSpan(
                                text: "create one here",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    },
  );
}
