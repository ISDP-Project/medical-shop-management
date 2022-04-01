part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User? user;

  const AuthenticationState({required this.status, this.user});

  @override
  List<Object?> get props => [status, user];
}

class AuthenticationStateUnknown extends AuthenticationState {
  const AuthenticationStateUnknown()
      : super(status: AuthenticationStatus.unknown);
}

class AuthenticationStateAuthenticated extends AuthenticationState {
  const AuthenticationStateAuthenticated(User user)
      : super(status: AuthenticationStatus.authenticated, user: user);
}

class AuthenticationStateUnauthenticated extends AuthenticationState {
  const AuthenticationStateUnauthenticated()
      : super(status: AuthenticationStatus.unauthenticated);
}
