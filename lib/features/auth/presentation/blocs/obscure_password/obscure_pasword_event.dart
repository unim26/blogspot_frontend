abstract class ObscurePasswordEvent {}


//obsure_password_toogle event
class ObscurePasswordToggleEvent extends ObscurePasswordEvent {
  final bool isObscure;
  ObscurePasswordToggleEvent({required this.isObscure});
}
