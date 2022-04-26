import 'package:supabase/supabase.dart';

class Userr extends User {
  /*
  Small extension of the `User` class built inside supabase
  */

  final String name;
  final String pharmacyId;
  final String pharmacyName;
  final String pharmacyGstin;

  Userr({
    required this.name,
    required this.pharmacyId,
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
