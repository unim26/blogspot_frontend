
import 'package:blogspot/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteUserState extends Equatable {
  final UserEntity? user;
  final String? message;

  const RemoteUserState({this.user, this.message});

  @override
  List<Object?> get props => [user, message];
}

//initial state
class RemoteUserInitialState extends RemoteUserState {
  const RemoteUserInitialState() : super(user: null, message: null);
}

//loading state
class RemoteUserLoadingState extends RemoteUserState {
  const RemoteUserLoadingState() : super(user: null, message: null);
}

//user loaded state
class RemoteUserLoadedState extends RemoteUserState {
  const RemoteUserLoadedState(UserEntity user)
      : super(user: user, message: null);
}

class RemoteUserLoggedOutState extends RemoteUserState {
  const RemoteUserLoggedOutState()
      : super(user: null, message: null);
}

class RemoteUserErrorState extends RemoteUserState {
  const RemoteUserErrorState(String message)
      : super(user: null, message: message);
}




