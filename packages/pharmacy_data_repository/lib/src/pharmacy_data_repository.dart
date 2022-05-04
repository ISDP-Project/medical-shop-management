import 'dart:developer';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:supabase/supabase.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

import './constants.dart';

class PharmacyDataRepository {
  final SupabaseClient _supabaseClient;
  final Uuid _uuid = Uuid();
  String? stockTableName = null;
  String? shipmentsTableName = null;
  String? billTableName = null;
  String? salesTableName = null;

  PharmacyDataRepository({
    required SupabaseClient supabaseClient,
  }) : this._supabaseClient = supabaseClient;

  void setPharmacyName(String? pharmacyGstin) {
    if (stockTableName == null && pharmacyGstin != null) {
      stockTableName = '${SqlNamesPrefix.stockTable}${pharmacyGstin}';
      shipmentsTableName = '${SqlNamesPrefix.shipmentsTable}${pharmacyGstin}';
      billTableName = '${SqlNamesPrefix.billsTable}${pharmacyGstin}';
      salesTableName = '${SqlNamesPrefix.salesTable}${pharmacyGstin}';
    } else {
      stockTableName = null;
      shipmentsTableName = null;
      billTableName = null;
      salesTableName = null;
    }
  }

  void addQuantity({
    required final int itemID,
    required final int quantity,
    required final int costPrice,
  }) async {
    if ((await checkItemExistence(itemID: itemID)) == false) {
      addNewItem(itemID: itemID, quantity: quantity, costPrice: costPrice);
    } else {
      final curTemp = await _supabaseClient
          .from(stockTableName!)
          .select(SqlNamesPharmacyStockTable.quantity)
          .eq(SqlNamesPharmacyStockTable.itemID, itemID)
          .execute();

      int currentItemQuantity =
          curTemp.data[0][SqlNamesPharmacyStockTable.quantity];
      final int finalQuantity = quantity + currentItemQuantity;

      await _supabaseClient
          .from(stockTableName!)
          .update({
            SqlNamesPharmacyStockTable.quantity: finalQuantity,
            // SqlNamesPharmacyStockTable.costPrice: costPrice
          })
          .eq(SqlNamesPharmacyStockTable.itemID, itemID)
          .execute();
    }
  }

  // void addMultipleQuantities({required final Map<String, int> items}) async {
  //   List itemIDList = items.keys.toList(growable: false);
  //   List quantityList = items.values.toList(growable: false);
  //   List costPriceList = items.values.toList(growable: false);
  //   print(costPriceList);
  //   print(itemIDList);
  //   print(quantityList);

  // for (int i = 0; i < itemIDList.length; i++) {
  //   addQuantity(itemID: itemIDList[i], quantity: quantityList[i]);
  // }
  // }

  void addNewItem({
    required final int itemID,
    required final int quantity,
    required final int costPrice,
  }) async {
    await _supabaseClient.from(stockTableName!).insert({
      SqlNamesPharmacyStockTable.itemID: itemID,
      SqlNamesPharmacyStockTable.quantity: quantity,
      // SqlNamesPharmacyStockTable.costPrice: costPrice,
    }).execute();
  }

  Future<bool> addIncomingStock(
      Map<Shipment, int> shipmentsWithQuantity) async {
    List<Map<String, dynamic>> query = [];

    shipmentsWithQuantity.forEach((shipment, quantity) {
      query.add({
        SqlNamesPharmacyShipmentsTable.id: _uuid.v4(),
        SqlNamesPharmacyShipmentsTable.arrivalDate:
            DateTime.now().toIso8601String(),
        SqlNamesPharmacyShipmentsTable.expDate:
            shipment.expDate.toIso8601String(),
        SqlNamesPharmacyShipmentsTable.mfgDate:
            shipment.mfgDate.toIso8601String(),
        SqlNamesPharmacyShipmentsTable.costPrice: shipment.costPrice,
        SqlNamesPharmacyShipmentsTable.medId: shipment.barcodeId,
      });
    });
    PostgrestResponse response =
        await _supabaseClient.from(shipmentsTableName!).upsert(query).execute();

    log('SHIPMENT DATA: ${response.data}');
    log('SHIPMENT ERROR: ${response.error}');

    if (response.hasError) return false;

    final prevStockResponse =
        await _supabaseClient.from(stockTableName!).select().execute();

    List<Map<String, dynamic>> newStockQuery = [];

    Map<String, int> prevStockQuantities = {};
    for (int i = 0; i < prevStockResponse.data.length; i++) {
      prevStockQuantities[prevStockResponse.data[i]
                  [SqlNamesPharmacyStockTable.itemID]
              .toString()] =
          prevStockResponse.data[i][SqlNamesPharmacyStockTable.quantity];
    }

    shipmentsWithQuantity.forEach((shipment, quantity) {
      newStockQuery.add({
        SqlNamesPharmacyStockTable.itemID: shipment.barcodeId,
        SqlNamesPharmacyStockTable.quantity:
            (prevStockQuantities[shipment.barcodeId] ?? 0) + quantity,
      });
    });

    response = await _supabaseClient
        .from(stockTableName!)
        .upsert(newStockQuery)
        .execute();

    log('STOCK DATA: ${response.data}');
    log('STOCK ERROR: ${response.error}');

    if (response.hasError) return false;

    return true;
  }

  // void removeQuantity({
  //   required final int itemID,
  //   required final int quantity,
  // }) async {
  //   final curTemp = await _supabaseClient
  //       .from(stockTableName!)
  //       .select(SqlNamesPharmacyStockTable.quantity)
  //       .eq(SqlNamesPharmacyStockTable.itemID, itemID)
  //       .execute();

  //   int currentItemQuantity =
  //       curTemp.data[0][SqlNamesPharmacyStockTable.quantity];
  //   final int finalQuantity = currentItemQuantity - quantity;

  //   await _supabaseClient
  //       .from(stockTableName!)
  //       .update({SqlNamesPharmacyStockTable.quantity: finalQuantity})
  //       .eq(SqlNamesPharmacyStockTable.itemID, itemID)
  //       .execute();
  // }

  Future<void> removeMultipleQuantities(
      {required final Map<Medicine, int> items}) async {
    if (items.isEmpty) return;
    List<Map<String, dynamic>> stockTableQuery = [];
    List<Map<String, dynamic>> salesTableQuery = [];
    String billId = _uuid.v4();
    double totalPrice = 0;

    items.forEach((medicine, quantitySold) {
      stockTableQuery.add({
        SqlNamesPharmacyStockTable.itemID: medicine.barcodeId,
        SqlNamesPharmacyStockTable.quantity: medicine.quantity - quantitySold,
      });

      salesTableQuery.add({
        SqlNamesPharmacySalesTable.id: _uuid.v4(),
        SqlNamesPharmacySalesTable.billId: billId,
        SqlNamesPharmacySalesTable.itemId: medicine.barcodeId,
        SqlNamesPharmacySalesTable.price: quantitySold * medicine.mrp,
        SqlNamesPharmacySalesTable.quantity: quantitySold,
      });

      totalPrice += medicine.mrp * quantitySold;
    });

    PostgrestResponse response = await _supabaseClient
        .from(stockTableName!)
        .upsert(stockTableQuery)
        .execute();

    if (response.hasError) throw 'Quantity Update Error';

    response = await _supabaseClient.from(billTableName!).insert({
      SqlNamesPharmacyBillsTable.id: billId,
      SqlNamesPharmacyBillsTable.totalPrice: totalPrice,
    }).execute();

    if (response.hasError) throw 'Quantity Update Error';

    response = await _supabaseClient
        .from(salesTableName!)
        .upsert(salesTableQuery)
        .execute();

    if (response.hasError) throw 'Quantity Update Error';
  }

  Future<bool> checkItemExistence({required final int itemID}) async {
    PostgrestResponse<dynamic> response = await _supabaseClient
        .from(stockTableName!)
        .select(SqlNamesPharmacyStockTable.quantity)
        .eq(SqlNamesPharmacyStockTable.itemID, itemID)
        .execute();

    if (response.data.isEmpty) return false;
    return true;
  }

  Future<List<Medicine>?> getAllItems({
    final bool includeZeroQuantityItems = true,
  }) async {
    // PostgrestResponse response = await _supabaseClient
    //     .from(pharmacyTableName)
    //     .select('''
    //       ${SqlNamesPharmacyStockTable.itemID},
    //       ${SqlNamesPharmacyStockTable.quantity},
    //       ${SqlNamesPharmacyStockTable.shouldNotify},
    //       ${SqlNameMedicineTable.tableName}!inner(${SqlNameMedicineTable.manufacturer}, ${SqlNameMedicineTable.medSaltName})
    //     ''')
    //     .eq('${SqlNameMedicineTable.tableName}.${SqlNameMedicineTable.barcodeNumber}',
    //         '${pharmacyTableName}.${SqlNamesPharmacyStockTable.itemID}')
    //     .execute();

    final PostgrestResponse stockResponse =
        await _supabaseClient.from(stockTableName!).select().execute();

    final PostgrestResponse medicinesResponse = await _supabaseClient
        .from(SqlNameMedicineTable.tableName)
        .select(
          '${SqlNameMedicineTable.barcodeNumber}, ${SqlNameMedicineTable.manufacturer}, ${SqlNameMedicineTable.medSaltName}, ${SqlNameMedicineTable.medMrp}',
        )
        .execute();

    // print('STOCK RESPONSE : ${stockResponse.data}');
    // print('STOCK ERROR : ${stockResponse.error}');

    // print('MED RESPONSE : ${medicinesResponse.data}');
    // print('MED ERROR : ${medicinesResponse.error}');

    if (stockResponse.hasError || medicinesResponse.hasError) return null;

    List<int> stockIds = [];
    for (int i = 0; i < stockResponse.data.length; i++) {
      stockIds.add(stockResponse.data[i][SqlNamesPharmacyStockTable.itemID]);
    }

    List filteredMedicines = [];
    for (int i = 0; i < medicinesResponse.data.length; i++) {
      if (stockIds.contains(
          medicinesResponse.data[i][SqlNameMedicineTable.barcodeNumber])) {
        filteredMedicines.add(medicinesResponse.data[i]);
      }
    }

    List stockData = [...stockResponse.data];

    filteredMedicines.sort((a, b) {
      return a[SqlNameMedicineTable.barcodeNumber]
          .compareTo(b[SqlNameMedicineTable.barcodeNumber]);
    });

    stockData.sort((a, b) {
      return a[SqlNamesPharmacyStockTable.itemID]
          .compareTo(b[SqlNamesPharmacyStockTable.itemID]);
    });
    // log(filteredMedicines.toString());
    List<Medicine> result = [];
    for (int i = 0; i < stockData.length; i++) {
      result.add(Medicine(
        barcodeId: stockData[i][SqlNamesPharmacyStockTable.itemID],
        name: filteredMedicines[i][SqlNameMedicineTable.medSaltName],
        manufacturer: filteredMedicines[i][SqlNameMedicineTable.manufacturer],
        quantity: stockData[i][SqlNamesPharmacyStockTable.quantity],
        mrp: double.parse(
            filteredMedicines[i][SqlNameMedicineTable.medMrp].toString()),
        shouldNotify: stockData[i][SqlNamesPharmacyStockTable.shouldNotify],
      ));
    }

    return result;
  }

  Future<void> updateNotificationSettings(
      List<int> changedIds, List<Medicine> medicines) async {
    List<Map<String, dynamic>> query = [];

    for (Medicine medicine in medicines) {
      if (changedIds.contains(medicine.barcodeId)) {
        query.add({
          SqlNamesPharmacyStockTable.itemID: medicine.barcodeId,
          SqlNamesPharmacyStockTable.quantity: medicine.quantity,
          SqlNamesPharmacyStockTable.shouldNotify: !medicine.shouldNotify,
        });
      }
    }

    final PostgrestResponse response =
        await _supabaseClient.from(stockTableName!).upsert(query).execute();
  }

  Future<List<Bill>?> getAllBills() async {
    final PostgrestResponse medicinesResponse = await _supabaseClient
        .from(SqlNameMedicineTable.tableName)
        .select(
          '${SqlNameMedicineTable.barcodeNumber}, ${SqlNameMedicineTable.manufacturer}, ${SqlNameMedicineTable.medSaltName}, ${SqlNameMedicineTable.medMrp}, ${SqlNameMedicineTable.medType}',
        )
        .execute();

    // log('MED RESPONSE : ${medicinesResponse.data}');
    // log('MED ERROR : ${medicinesResponse.error}');

    if (medicinesResponse.hasError) return null;

    List<Medicine> medicines = [];

    for (int i = 0; i < medicinesResponse.data.length; i++) {
      medicines.add(Medicine(
        barcodeId: medicinesResponse.data[i][SqlNameMedicineTable.barcodeNumber],
        name: medicinesResponse.data[i][SqlNameMedicineTable.medSaltName],
        manufacturer: medicinesResponse.data[i]
            [SqlNameMedicineTable.manufacturer],
        quantity: -1,
        mrp: double.parse(
            medicinesResponse.data[i][SqlNameMedicineTable.medMrp].toString()),
        shouldNotify: false,
      ));
    }

    final PostgrestResponse billsResponse =
        await _supabaseClient.from(billTableName!).select().execute();

    // log('BILLS RESPONSE : ${billsResponse.data}');
    // log('BILLS ERROR : ${billsResponse.error}');

    if (billsResponse.hasError) return null;

    final PostgrestResponse salesResponse =
        await _supabaseClient.from(salesTableName!).select().execute();

    // log('SALES RESPONSE : ${salesResponse.data}');
    // log('SALES ERROR : ${salesResponse.error}');

    if (salesResponse.hasError) return null;

    List<Bill> bills = [];
    for (int i = 0; i < billsResponse.data.length; i++) {
      List<Sale> sales = [];

      for (int j = 0; j < salesResponse.data.length; j++) {
        if (salesResponse.data[j][SqlNamesPharmacySalesTable.billId] ==
            billsResponse.data[i][SqlNamesPharmacyBillsTable.id]) {
          sales.add(Sale(
            uid: salesResponse.data[j][SqlNamesPharmacySalesTable.id],
            medicine: medicines.firstWhere(
              (element) =>
                  element.barcodeId ==
                  
                      salesResponse.data[j][SqlNamesPharmacySalesTable.itemId],
            ),
            price: double.parse(
                salesResponse.data[j][SqlNamesPharmacySalesTable.price].toString()),
            quantity: int.parse(
                salesResponse.data[j][SqlNamesPharmacySalesTable.quantity].toString()),
          ));
        }
      }

      if (sales.isNotEmpty) {
        bills.add(
          Bill(
            sales,
            DateFormat('yyyy-MM-dd')
                .parse(billsResponse.data[i][SqlNamesPharmacyBillsTable.date]),
            billsResponse.data[i][SqlNamesPharmacyBillsTable.id],
          ),
        );
      } else {
        log('THE DB DESIGN JUST BROKE DOWN');
      }
    }

    return bills;
  }

  Future< List<Medicine>? > getAllMedicines() async {
    final PostgrestResponse medicinesResponse = await _supabaseClient
        .from(SqlNameMedicineTable.tableName)
        .select(
          '${SqlNameMedicineTable.barcodeNumber}, ${SqlNameMedicineTable.manufacturer}, ${SqlNameMedicineTable.medSaltName}, ${SqlNameMedicineTable.medMrp}, ${SqlNameMedicineTable.medType}',
        )
        .execute();

    // log('MED RESPONSE : ${medicinesResponse.data}');
    // log('MED ERROR : ${medicinesResponse.error}');

    if (medicinesResponse.hasError) return null;

    List<Medicine> medicines = [];

    for (int i = 0; i < medicinesResponse.data.length; i++) {
      medicines.add(Medicine(
        barcodeId: medicinesResponse.data[i][SqlNameMedicineTable.barcodeNumber],
        name: medicinesResponse.data[i][SqlNameMedicineTable.medSaltName],
        manufacturer: medicinesResponse.data[i]
            [SqlNameMedicineTable.manufacturer],
        quantity: -1,
        mrp: double.parse(
            medicinesResponse.data[i][SqlNameMedicineTable.medMrp].toString()),
        shouldNotify: false,
      ));
    }

    return medicines;
  }
}

// TODO:
// 1. add plpgsql funciton to check existence and add/subtract stock of multiple items
// 2. remind sahej to make a trigger that creates a pharmacy table
// 3. remind costPrice to sahej during DB work
