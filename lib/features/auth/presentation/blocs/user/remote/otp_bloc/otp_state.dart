import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable {
  final bool? isOtpSent;
  final bool? isOtpVerified;
  final String? message;

  const OtpState({this.isOtpSent, this.message, this.isOtpVerified});

  @override
  List<Object?> get props => [isOtpSent, message, isOtpVerified];
}

//initial state
class OtpInitialState extends OtpState {
  const OtpInitialState() : super(isOtpSent: null, message: null);
}

//loading state
class OtpLoadingState extends OtpState {
  const OtpLoadingState() : super(isOtpSent: null, message: null);
}

//otp send state
class OtpSentState extends OtpState {
  const OtpSentState() : super(isOtpSent: true, message: null);
}

//otp verified state
class OtpVerifiedState extends OtpState {
  const OtpVerifiedState() : super(isOtpVerified: true);
}

//otp failed state
class OtpFailedState extends OtpState {
  const OtpFailedState(String message)
      : super(isOtpSent: false, message: message,isOtpVerified: false);
}
