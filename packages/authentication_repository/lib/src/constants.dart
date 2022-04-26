class SqlNamesUsersTable {
  static const String tableName = 'users_profile';
  static const String id = 'id';
  static const String name = 'name';
  static const String pharmacyId = 'pharmacy_id';
}

class SqlNamesPharmaciesTable {
  static const String tableName = 'pharmacies';
  static const String id = 'id';
  static const String legalName = 'legal_name';
  static const String gstin = 'gstin';
  static const String registeredAt = 'registered_at';
}

class SqlNamesRpc {
  static const String fetchUserProfile = 'get_user_profile';
}
