import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:supabase/supabase.dart';
import 'package:bloc/bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';

import './app.dart';
import 'login_signup.dart';
import './homepage.dart';
import 'routes.dart';
import 'signup.dart';

void main() async {
  return BlocOverrides.runZoned(() async {
    final _supabase = SupabaseClient('https://mgjdpeeyigrhdxcnqkaz.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1namRwZWV5aWdyaGR4Y25xa2F6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg0NDM1MDcsImV4cCI6MTk2NDAxOTUwN30.z-pRYrMNxlbSgmhw9B7AxYYukocvRpSdraPNA2QOHO8');

    AuthenticationRepository _authenticationRepository =
        AuthenticationRepository(_supabase);
    // TODO: Dependency Injection
    runApp(const App());
  });
}




























    // return MediaQuery(
    //   data: MediaQueryData(),
    //   child: MaterialApp(
    //     theme: ThemeData(
    //         primarySwatch: Colors.deepPurple,
    //         // fontFamily: GoogleFonts.lato().fontFamily
    //         //primaryTextTheme: GoogleFonts.abelTextTheme()
    //         ),
    //     themeMode: ThemeMode.light,
    //     darkTheme: ThemeData(brightness: Brightness.dark),
    
    //     routes:{
    //       "/":(context) => HomePage(),
    //       MyRoutes.homeRoute: (context) => HomePage()
    //     }
    //   ),
    // );
 