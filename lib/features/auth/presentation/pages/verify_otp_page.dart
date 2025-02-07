import 'package:blogspot/core/utils/widgests/my_button.dart';
import 'package:blogspot/core/utils/widgests/my_snack_bar.dart';
import 'package:blogspot/core/utils/widgests/my_text_field.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/local/timer_provider.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/otp_bloc/otp_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/otp_bloc/otp_event.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/otp_bloc/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage(
      {super.key, required this.routeName, required this.email});

  final String routeName;
  final String email;

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    context.read<TimerProvider>().start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          //if state is error state
          if (state is OtpFailedState) {
            //show error message
            mySnacBar(
              context,
              color: Colors.red,
              message: "OTP is Invalid,please enter a valid OTP",
            );
          }

          //if otpsentsuccess state
          if (state is OtpSentState) {
            //show message that otp sent successfully to their email
            mySnacBar(
              context,
              color: Colors.green,
              message: 'Otp sent successfullt to ${widget.email}',
            );
          }

          //if state is success state
          if (state is OtpVerifiedState) {
            //show success message
            mySnacBar(
              context,
              color: Colors.green,
              message: "OTP verified..!,Update your password",
            );

            //navigate to next page ('changePassword page')
            Navigator.pushReplacementNamed(
              context,
              widget.routeName,
              arguments: widget.email,
            );
          }
        },
        builder: (context, state) {

          //if state is loading state
          if (state is OtpLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //if state is not loading state
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

                  //text field ------> otp

                  myTextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
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
                        if (otpController.text.isNotEmpty) {
                          context.read<OtpBloc>().add(
                                VerifyOtpEvent(
                                    email: widget.email,
                                    otp: otpController.text),
                              );
                        } else {
                          //show error message
                          mySnacBar(context,
                              color: Colors.red, message: "OTP is required");
                        }
                      }),

                  //text button ---> resend otp
                  Consumer<TimerProvider>(
                    builder: (context, value, child) {
                      return TextButton(
                        onPressed: () {
                          if (!value.isrunning) {
                            context.read<OtpBloc>().add(
                                  SendOtpEvent(email: widget.email),
                                );
                          }
                        },
                        child: Text(
                          value.isrunning
                              ? "Resend OTP? ${value.minute}m ${value.second}s"
                              : "Didn't receive the OTP? Tap here to resend!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: sHeight * .022,
                            color:
                                value.isrunning ? Colors.black54 : Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
