class SqlNamesUsersTable {
  static const String tableName = 'users_profile';
  static const String id = 'id';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String phoneNo = 'phone';
  static const String pharmacyGstin = 'pharmacy_gstin';
}

class SqlNamesPharmaciesTable {
  static const String tableName = 'pharmacies';
  static const String legalName = 'legal_name';
  static const String gstin = 'gstin';
  static const String address = 'address';
  static const String city = 'city';
  static const String pinCode = 'pin_code';
  static const String registeredAt = 'registered_at';
}

class SqlNamesRpcMethods {
  static const String fetchUserProfile = 'get_user_profile';
  static const String populatePharmacyTable = 'populate_pharmacy';
  static const String populateUserProfileTable = 'populate_user_profile';
}

class RpcCreateProfile {
  static const String firstName = 'v_first_name';
  static const String lastName = 'v_last_name';
  static const String phoneNo = 'v_phone';
  static const String pharmacyGstin = 'v_pharmacy_gstin';
  static const String pharmacyLegalName = 'v_pharmacy_legal_name';
  static const String pharmacyAddress = 'v_pharmacy_address';
  static const String pharmacyCity = 'v_pharmacy_city';
  static const String pharmacyPinCode = 'v_pharmacy_pin_code';
}
