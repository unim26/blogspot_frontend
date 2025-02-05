abstract class PasswordEvent {}

//forgot password event
class ForgotPasswordEvent extends PasswordEvent {
  final String email;
  final String password;

  ForgotPasswordEvent({required this.email, required this.password});
}
