import 'package:blogspot/core/utils/widgests/my_button.dart';
import 'package:blogspot/core/utils/widgests/my_snack_bar.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_event.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RemoteUserBloc, RemoteUserState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("HOME PAGE"),
              ),

              //button
              myButton(
                  bName: "logout",
                  onPressed: () {
                    context.read<RemoteUserBloc>().add(RemoteUserLogoutEvent());
                    Navigator.pushReplacementNamed(context, 'loginPage');
                    mySnacBar(
                      context,
                      color: Colors.green,
                      message: 'Successfully logged out..!',
                    );
                  })
            ],
          );
        },
      ),
    );
  }
}
