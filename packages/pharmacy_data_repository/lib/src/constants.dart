class SqlNamesPharmacyStockTable {
  static const String itemID = 'item_id';
  static const String quantity = 'quantity';
  static const String shouldNotify = 'should_notify';
}

class SqlNamesPharmacyShipmentsTable {
  static const String id = 'id';
  static const String arrivalDate = 'date';
  static const String mfgDate = 'mfg_date';
  static const String expDate = 'exp_date';
  static const String costPrice = 'cost_price';
  static const String medId = 'barcode_id';
}

class SqlNamesPharmacyBillsTable {
  static const String id = 'id';
  static const String date = 'date';
  static const String totalPrice = 'total_price';
}

class SqlNamesPharmacySalesTable {
  static const String id = 'id';
  static const String billId = 'bill_id';
  static const String itemId = 'item_id';
  static const String price = 'price';
  static const String quantity = 'quantity';
}

class SqlNamesPrefix {
  static const String stockTable = 'pharmacy_stock_';
  static const String shipmentsTable = 'shipments_';
  static const String billsTable = 'bills_';
  static const String salesTable = 'sales_';
}

class SqlNamesRpc {
  static const String getAllMedicines = 'get_all_medicines';
}

class SqlNamesGelAllMedicinesArgs {
  static const String pharmacyStockTableName = 'v_pharmacy_stock_table_name';
}

class SqlNameMedicineTable {
  static const String tableName = 'medicine';
  static const String barcodeNumber = 'barcode_id';
  static const String medSaltName = 'salt_name';
  static const String medType = 'type_id';
  static const String medMrp = 'mrp';
  static const String manufacturer = 'manufacturer';
}
