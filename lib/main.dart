import 'package:flutter/material.dart';
import 'package:master_db_repository/master_db_repository.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

// import 'package:pharmacy_data_repository/src/pharmacy_data_repository.dart';
import 'package:supabase/supabase.dart';
import 'package:bloc/bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
// import 'package:master_db_repository/master_db_repository.dart';

import './app.dart';

void main() async {
  return BlocOverrides.runZoned(() async {
    final _supabase = SupabaseClient('https://mgjdpeeyigrhdxcnqkaz.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1namRwZWV5aWdyaGR4Y25xa2F6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg0NDM1MDcsImV4cCI6MTk2NDAxOTUwN30.z-pRYrMNxlbSgmhw9B7AxYYukocvRpSdraPNA2QOHO8');

    AuthenticationRepository _authenticationRepository =
        AuthenticationRepository(_supabase);
    MasterDBHandler _masterDbRepository = MasterDBHandler(_supabase);

    PharmacyDataRepository pharmacyDataRep =
        PharmacyDataRepository(_supabase, 'gstin_he73isbf8');

    runApp(
      App(
        authenticationRepository: _authenticationRepository,
      ),
    );
  });

  // final _supabase = SupabaseClient('https://mgjdpeeyigrhdxcnqkaz.supabase.co',
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1namRwZWV5aWdyaGR4Y25xa2F6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg0NDM1MDcsImV4cCI6MTk2NDAxOTUwN30.z-pRYrMNxlbSgmhw9B7AxYYukocvRpSdraPNA2QOHO8');

  // final res = await _supabase.rpc(
  //   'populate_user_pharmacy_profile',
  //   params: {
  //     'v_first_name': 'Sahej',
  //     'v_last_name': 'Singh',
  //     'v_pharmacy_gstin': 'abc123gst',
  //     'v_pharmacy_legal_name': 'Drips n\' Drugs',
  //     'v_pharmacy_address': 'NIIT University',
  //     'v_pharmacy_city': 'Neemrana',
  //     'v_pharmacy_pin_code': '156337'
  //   },
  // ).execute();

  // print("RESPONSE: ${res.status}");
  // print('ERROR: ${res.error}');
  // print('DATA: ${res.data}');
}
