abstract class OtpEvent {}

//send otp event
class SendOtpEvent extends OtpEvent {
  final String email;

  SendOtpEvent({required this.email});
}

//verify otp event
class VerifyOtpEvent extends OtpEvent {
  final String email;
  final String otp;

  VerifyOtpEvent({required this.email,required this.otp});
}
