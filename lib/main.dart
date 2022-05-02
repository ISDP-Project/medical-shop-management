import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:master_db_repository/master_db_repository.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

// import 'package:pharmacy_data_repository/src/pharmacy_data_repository.dart';
import 'package:supabase/supabase.dart';
import 'package:bloc/bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
// import 'package:master_db_repository/master_db_repository.dart';
// import 'package:analytic'

import 'cloud_messaging/messaing.dart';

import './app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  return BlocOverrides.runZoned(() async {
    final _supabase = SupabaseClient('https://mgjdpeeyigrhdxcnqkaz.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1namRwZWV5aWdyaGR4Y25xa2F6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg0NDM1MDcsImV4cCI6MTk2NDAxOTUwN30.z-pRYrMNxlbSgmhw9B7AxYYukocvRpSdraPNA2QOHO8');

    AuthenticationRepository _authenticationRepository =
        AuthenticationRepository(_supabase);
    MasterDBHandler _masterDbRepository = MasterDBHandler(_supabase);

    PharmacyDataRepository pharmacyDataRep =
        PharmacyDataRepository(_supabase, 'gstin_he73isbf8');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    runApp(
      App(
        authenticationRepository: _authenticationRepository,
      ),
    );
  });
}
