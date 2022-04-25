import 'dart:async';

import 'package:uuid/uuid.dart';
import 'package:supabase/supabase.dart';

import './constants.dart';
import 'userr.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _uuid = Uuid();

  Userr? _userr;
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
    required String pharmacyName,
    required String pharmacyGstin,
  }) async {
    final res = await _supabase.auth.signUp(
      email,
      password,
    );

    if (res.error == null) {
      String pharmacyUid = _uuid.v4();

      await _supabase.from(SqlNamesPharmaciesTable.tableName).insert({
        SqlNamesPharmaciesTable.id: pharmacyUid,
        SqlNamesPharmaciesTable.legalName: pharmacyName,
        SqlNamesPharmaciesTable.gstin: pharmacyGstin,
      }).execute();

      await _supabase.from(SqlNamesUsersTable.tableName).insert({
        SqlNamesUsersTable.id: res.user!.id,
        SqlNamesUsersTable.name: name,
        SqlNamesUsersTable.pharmacyId: pharmacyUid,
      }).execute();

      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> logOut() async {
    final res = await _supabase.auth.signOut();
    if (res.error == null) {
      _controller.add(AuthenticationStatus.unauthenticated);
      _userr = null;
    }
  }

  Future<Userr?> getUser() async {
    if (_userr != null) return _userr;

    User? user = await _supabase.auth.user();

    final PostgrestResponse response =
        await _supabase.rpc(SqlNamesRpc.fetchUserProfile).execute();

    if (response.hasError) return null;

    final String name = response.data[SqlNamesUsersTable.name];
    final String pharmacyId = response.data[SqlNamesUsersTable.pharmacyId];
    final String pharmacyName =
        response.data[SqlNamesPharmaciesTable.legalName];
    final String pharmacyGstin = response.data[SqlNamesPharmaciesTable.gstin];

    return Userr(
      name: name,
      pharmacyId: pharmacyId,
      pharmacyName: pharmacyName,
      pharmacyGstin: pharmacyGstin,
      user: user!,
    );
  }

  void dispose() => _controller.close();
}
