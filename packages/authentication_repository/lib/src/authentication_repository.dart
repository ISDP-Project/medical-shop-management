import 'dart:async';
import 'dart:developer';

import 'package:supabase/supabase.dart';

import './constants.dart';
import 'userr.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

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
    required String firstName,
    required String lastName,
    required String phoneNo,
    required String pharmacyName,
    required String pharmacyGstin,
    required String pharmacyAddress,
    required String pharmacyCity,
    required String pharmacyPinCode,
  }) async {
    final signUpResponse = await _supabase.auth.signUp(
      email,
      password,
    );

    if (signUpResponse.error != null) {
      _controller.add(AuthenticationStatus.unauthenticated);
      print('SIGNUP ERROR: ${signUpResponse.error}');
      return;
    }
    // String pharmacyUid = _uuid.v4();

    // await _supabase.from(SqlNamesPharmaciesTable.tableName).insert({
    //   SqlNamesPharmaciesTable.id: pharmacyUid,
    //   SqlNamesPharmaciesTable.legalName: pharmacyName,
    //   SqlNamesPharmaciesTable.gstin: pharmacyGstin,
    // }).execute();

    // await _supabase.from(SqlNamesUsersTable.tableName).insert({
    //   SqlNamesUsersTable.id: res.user!.id,
    //   SqlNamesUsersTable.name: name,
    //   SqlNamesUsersTable.pharmacyId: pharmacyUid,
    // }).execute();

    PostgrestResponse rpcResponse = await _supabase.rpc(
      SqlNamesRpcMethods.populatePharmacyTable,
      params: {
        RpcCreateProfile.pharmacyGstin: pharmacyGstin,
        RpcCreateProfile.pharmacyLegalName: pharmacyName,
        RpcCreateProfile.pharmacyAddress: pharmacyAddress,
        RpcCreateProfile.pharmacyCity: pharmacyCity,
        RpcCreateProfile.pharmacyPinCode: pharmacyPinCode,
      },
    ).execute();

    if (rpcResponse.error != null) {
      _controller.add(AuthenticationStatus.unauthenticated);
      print('PHARMACY ERROR: ${rpcResponse.error}');
      return;
    }

    rpcResponse = await _supabase.rpc(
      SqlNamesRpcMethods.populateUserProfileTable,
      params: {
        RpcCreateProfile.firstName: firstName,
        RpcCreateProfile.lastName: lastName,
        RpcCreateProfile.phoneNo: phoneNo,
        RpcCreateProfile.pharmacyGstin: pharmacyGstin,
      },
    ).execute();

    if (rpcResponse.error != null) {
      _controller.add(AuthenticationStatus.unauthenticated);
      print('PROFILE ERROR: ${rpcResponse.error}');
      return;
    }
    _controller.add(AuthenticationStatus.authenticated);
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
        await _supabase.rpc(SqlNamesRpcMethods.fetchUserProfile).execute();

    if (response.hasError) return null;

    log('RESPONSE DATA: ${response.data}');

    final String firstName = response.data[SqlNamesUsersTable.firstName];
    final String lastName = response.data[SqlNamesUsersTable.lastName];
    final String phoneNo = response.data[SqlNamesUsersTable.phoneNo];
    final String pharmacyGstin =
        response.data[SqlNamesUsersTable.pharmacyGstin];
    final String pharmacyName =
        response.data[SqlNamesPharmaciesTable.legalName];
    final String pharmacyAddress =
        response.data[SqlNamesPharmaciesTable.address];
    final String pharmacyCity = response.data[SqlNamesPharmaciesTable.city];
    final String pharmacyPinCode =
        response.data[SqlNamesPharmaciesTable.pinCode];

    return Userr(
      firstName: firstName,
      lastName: lastName,
      phoneNo: phoneNo,
      pharmacyGstin: pharmacyGstin,
      pharmacyName: pharmacyName,
      pharmacyAddress: pharmacyAddress,
      pharmacyCity: pharmacyCity,
      pharmacyPinCode: pharmacyPinCode,
      user: user!,
    );
  }

  void dispose() => _controller.close();
}
