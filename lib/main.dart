import 'package:flutter/material.dart';
import 'package:master_db_repository/master_db_repository.dart';

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
    runApp(App(
      authenticationRepository: _authenticationRepository,
    ));
  });
}

    // PharmacyDataRepository _pharmacyDataRepository =
    //     PharmacyDataRepository(_supabase, 'gstin_he73isbf8');
    // print('hi');
    // // _pharmacyDataRepository.addQuantity(itemID: 9837498238, quantity: 50);
    // // _pharmacyDataRepository.removeQuantity(itemID: 9837498238, quantity: 50);
    // _pharmacyDataRepository.addNewItem(itemID: 765858858, quantity: 100);
    // print('dn');

