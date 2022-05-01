import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:supabase/supabase.dart';
import 'package:bloc/bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:master_db_repository/master_db_repository.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

import './app.dart';

void main() async {
  return BlocOverrides.runZoned(() async {
    final _supabase = SupabaseClient('https://mgjdpeeyigrhdxcnqkaz.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1namRwZWV5aWdyaGR4Y25xa2F6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg0NDM1MDcsImV4cCI6MTk2NDAxOTUwN30.z-pRYrMNxlbSgmhw9B7AxYYukocvRpSdraPNA2QOHO8');

    AuthenticationRepository _authenticationRepository =
        AuthenticationRepository(_supabase);
    MasterDBHandler _masterDbRepository = MasterDBHandler(_supabase);

    PharmacyDataRepository _pharmacyDataRepository =
        PharmacyDataRepository(supabaseClient: _supabase);

    runApp(
      App(
        authenticationRepository: _authenticationRepository,
        pharmacyDataRepository: _pharmacyDataRepository,
      ),
    );
  });
  // final _supabase = SupabaseClient('https://mgjdpeeyigrhdxcnqkaz.supabase.co',
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1namRwZWV5aWdyaGR4Y25xa2F6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg0NDM1MDcsImV4cCI6MTk2NDAxOTUwN30.z-pRYrMNxlbSgmhw9B7AxYYukocvRpSdraPNA2QOHO8');

  // PharmacyDataRepository pharmacyDataRep = PharmacyDataRepository(
  //     supabaseClient: _supabase, pharmacyGstin: 'abc321');

  // final res =
  //     await pharmacyDataRep.getAllItems(includeZeroQuantityItems: false);
  // print('RETURNS $res');
}
