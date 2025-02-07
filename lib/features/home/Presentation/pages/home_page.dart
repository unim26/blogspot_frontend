import 'package:blogspot/core/utils/widgests/my_button.dart';
import 'package:blogspot/core/utils/widgests/my_snack_bar.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_event.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RemoteUserBloc, RemoteUserState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("$_currentIndex"),
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
                },
              )
            ],
          );
        },
      ),

      ///bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // backgroundColor: Colors.white38,
        elevation: .5,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color.fromARGB(255, 255, 172, 47),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.black87,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          //all blog button
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          //my blog button
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            label: 'My Blogs',
          ),
          //all blog button
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_rounded,
            ),
            label: 'Add Blog',
          ),
          //all blog button
          BottomNavigationBarItem(
            icon: Icon(Icons.save_rounded),
            label: 'Saved Blogs',
          ),
          //all blog button
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
