part of 'authentication_bloc.dart';

enum AuthenticationType { login, signup }

@immutable
abstract class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final Userr? user;
  final AuthenticationType? authenticationType;
  final bool? showError;

  const AuthenticationState({
    required this.status,
    this.user,
    this.authenticationType,
    this.showError,
  });

  @override
  List<Object?> get props => [status, user?.id, authenticationType, showError];
}

class AuthenticationStateUnknown extends AuthenticationState {
  const AuthenticationStateUnknown()
      : super(status: AuthenticationStatus.unknown);
}

class AuthenticationStateAuthenticated extends AuthenticationState {
  const AuthenticationStateAuthenticated(Userr user)
      : super(status: AuthenticationStatus.authenticated, user: user);
}

class AuthenticationStateUnauthenticated extends AuthenticationState {
  const AuthenticationStateUnauthenticated(
      {AuthenticationType authenticationType = AuthenticationType.signup,
      bool showError = false})
      : super(
          status: AuthenticationStatus.unauthenticated,
          authenticationType: authenticationType,
          showError: showError,
        );
}
