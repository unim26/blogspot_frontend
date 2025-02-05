import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LocalUserState { loggedIn, notLoggedIn }

class LocalUserCubit extends Cubit<LocalUserState> {
  LocalUserCubit() : super(LocalUserState.notLoggedIn);

//check if user is logged in
  void isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    if (token != null) {
      emit(LocalUserState.loggedIn);
    } else {
      emit(LocalUserState.notLoggedIn);
    }
  }

  //save token for
  void saveUserAuthToken(String token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      emit(LocalUserState.loggedIn);
    } catch (e) {
      emit(LocalUserState.notLoggedIn);
    }
  }
}
