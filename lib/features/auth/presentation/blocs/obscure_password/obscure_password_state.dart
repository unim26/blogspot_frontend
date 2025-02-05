import 'package:equatable/equatable.dart';

abstract class ObscurePasswordState extends Equatable {
  final bool isObsucre;
  const ObscurePasswordState({required this.isObsucre});

  @override
  List<Object> get props => [isObsucre];
}


class ObscurePasswordInitial extends ObscurePasswordState {
  const ObscurePasswordInitial() : super(isObsucre: true);
}

class ObscurePasswordToggled extends ObscurePasswordState {
   const ObscurePasswordToggled({required super.isObsucre});
}
