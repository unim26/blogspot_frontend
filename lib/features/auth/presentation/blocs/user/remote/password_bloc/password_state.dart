import 'package:equatable/equatable.dart';

abstract class PasswordState extends Equatable {
  final bool? isPasswordChanged;
  final String? message;

  const PasswordState({this.isPasswordChanged, this.message});

  @override
  List<Object?> get props => [isPasswordChanged, message];
}

//initial state
class PasswordInitialState extends PasswordState {
  const PasswordInitialState() : super(isPasswordChanged: null, message: null);
}

//loading state
class PasswordLoadingState extends PasswordState {
  const PasswordLoadingState() : super(isPasswordChanged: null, message: null);
}

//password forgoted state
class PasswordForgotedState extends PasswordState {
  const PasswordForgotedState() : super(isPasswordChanged: true, message: null);
}

//fail to password forgot state
class PasswordFailToForgotState extends PasswordState {
  const PasswordFailToForgotState(String message)
      : super(isPasswordChanged: false, message: message);
}
