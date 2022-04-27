import 'package:supabase/supabase.dart';

class Userr extends User {
  /*
  Small extension of the `User` class built inside supabase
  */

  final String firstName;
  final String lastName;
  final String phoneNo;
  final String pharmacyName;
  final String pharmacyGstin;
  final String pharmacyAddress;
  final String pharmacyCity;
  final String pharmacyPinCode;

  Userr({
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.pharmacyAddress,
    required this.pharmacyCity,
    required this.pharmacyPinCode,
    required this.pharmacyName,
    required this.pharmacyGstin,
    required User user,
  }) : super(
          updatedAt: user.updatedAt,
          role: user.role,
          aud: user.aud,
          createdAt: user.createdAt,
          userMetadata: user.userMetadata,
          email: user.email,
          appMetadata: user.appMetadata,
          phone: user.phone,
          id: user.id,
        );
}
