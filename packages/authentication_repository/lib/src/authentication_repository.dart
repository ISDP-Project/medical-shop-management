import 'dart:async';

import 'package:supabase/supabase.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  SupabaseClient _supabase;

  AuthenticationRepository(this._supabase);

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final res = await _supabase.auth.signIn(email: email, password: password);

    if (res.error == null) {
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final res = await _supabase.auth.signUp(
      email,
      password,
      userMetadata: {
        'name': name,
      },
    );

    if (res.error == null) {
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> logOut() async {
    final res = await _supabase.auth.signOut();
    if (res.error == null) {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<User?> getUser() async {
    return _supabase.auth.user();
  }

  void dispose() => _controller.close();
}
