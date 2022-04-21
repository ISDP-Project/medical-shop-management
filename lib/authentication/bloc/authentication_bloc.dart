import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationStateUnknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationTypeChangeRequested>(_onAuthenticationTypeChangeRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  bool _showError = false;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        emit(AuthenticationStateUnauthenticated(
          showError: _showError,
          authenticationType:
              state.authenticationType ?? AuthenticationType.signup,
        ));
        if (!_showError) {
          _showError = true;
        }
        break;
      case AuthenticationStatus.authenticated:
        final user = await _authenticationRepository.getUser();
        emit(user != null
            ? AuthenticationStateAuthenticated(user)
            : const AuthenticationStateUnauthenticated());
        break;
      default:
        emit(const AuthenticationStateUnknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  void _onAuthenticationTypeChangeRequested(
    AuthenticationTypeChangeRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    // _showError = true;
    if (state.authenticationType == AuthenticationType.login) {
      emit(const AuthenticationStateUnauthenticated(
        authenticationType: AuthenticationType.signup,
      ));
    } else {
      emit(const AuthenticationStateUnauthenticated(
        authenticationType: AuthenticationType.login,
      ));
    }
  }
}
