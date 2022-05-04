import 'package:flutter/material.dart';

import 'package:supabase/supabase.dart';
import 'package:bloc/bloc.dart';
import 'package:barcode_repository/barcode_repository.dart';
import 'package:master_db_repository/master_db_repository.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

import './app.dart';

void main() async {
  return BlocOverrides.runZoned(() async {
    final _supabase = SupabaseClient('https://mgjdpeeyigrhdxcnqkaz.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1namRwZWV5aWdyaGR4Y25xa2F6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg0NDM1MDcsImV4cCI6MTk2NDAxOTUwN30.z-pRYrMNxlbSgmhw9B7AxYYukocvRpSdraPNA2QOHO8');

    AuthenticationRepository _authenticationRepository =
        AuthenticationRepository(_supabase);

    MasterDBHandler _masterDbRepository = MasterDBHandler(_supabase);

    BarcodeRepository _barcodeRepository = BarcodeRepository(
      // apiKey: '64663512EB80F6E894AFE6E0987E9233',
      apiKey: '92C374E6202EDAB9E6EE118AB51ED9F0',
      supabase: _supabase,
    );

    PharmacyDataRepository _pharmacyDataRepository =
        PharmacyDataRepository(supabaseClient: _supabase);

    runApp(
      App(
        authenticationRepository: _authenticationRepository,
        pharmacyDataRepository: _pharmacyDataRepository,
        barcodeRepository: _barcodeRepository,
        masterDBHandler: _masterDbRepository,
      ),
    );
  });
  // final _supabase = SupabaseClient('https://mgjdpeeyigrhdxcnqkaz.supabase.co',
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1namRwZWV5aWdyaGR4Y25xa2F6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg0NDM1MDcsImV4cCI6MTk2NDAxOTUwN30.z-pRYrMNxlbSgmhw9B7AxYYukocvRpSdraPNA2QOHO8');

  // BarcodeRepository barcodeRepository =
  //     BarcodeRepository(apiKey: '64663512EB80F6E894AFE6E0987E9233');

  // final res = await barcodeRepository.getItems('7872175892031'); // LOOK UP SUCCESS
  // final res = await barcodeRepository.getItems('8901725148324'); // SEARCH SUCCESS
  // final res = await barcodeRepository.getItems('5045097634276'); // SEARCH FAIL

  // final res = await _supabase
  //     .from('medicine')
  //     .select()
  //     .eq('barcode_id', '1234560987')
  //     .execute();

  // print('DATA: ${res.data}');
  // print('ERROR: ${res.error}');
  // print('RETURNS: $res');
}
