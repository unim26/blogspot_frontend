abstract class RemoteUserEvent {
  const RemoteUserEvent();
}

//login event
class RemoteUserLoginEvent extends RemoteUserEvent {
  final String email;
  final String password;

  RemoteUserLoginEvent({required this.email, required this.password});
}

//logout event
class RemoteUserLogoutEvent extends RemoteUserEvent {
  const RemoteUserLogoutEvent();
}

//signup event
class RemoteUserRegisterEvent extends RemoteUserEvent {
  final String fullName;
  final String email;
  final String password;

  RemoteUserRegisterEvent(
      {required this.fullName, required this.email, required this.password});
}
