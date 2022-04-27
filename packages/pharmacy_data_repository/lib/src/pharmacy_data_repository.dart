import 'package:supabase/supabase.dart';

import './constants.dart';


class PharmacyDataRepository {
  final SupabaseClient _supabaseClient;
  final String
      pharmacyTableName; // table name: 'gstin_' + pharmacyGSTIN (name: gstin_abc12def345, pharmacyGSTIN: abc12def345)
  PharmacyDataRepository(this._supabaseClient, this.pharmacyTableName);

  void addQuantity({
    required final int itemID,
    required final int quantity,
  }) async {
    if ((await checkItemExistence(itemID: itemID)) == false) {
      addNewItem(itemID: itemID, quantity: quantity);
    } else {
      final curTemp = await _supabaseClient
          .from(pharmacyTableName)
          .select(SqlNamePharmacyTable.quantity)
          .eq(SqlNamePharmacyTable.itemID, itemID)
          .execute();

      int currentItemQuantity = curTemp.data[0][SqlNamePharmacyTable.quantity];
      final int finalQuantity = quantity + currentItemQuantity;

      await _supabaseClient
          .from(pharmacyTableName)
          .update({SqlNamePharmacyTable.quantity: finalQuantity})
          .eq(SqlNamePharmacyTable.itemID, itemID)
          .execute();
    }
  }

  void addMultipleQuantities({required final Map<String, int> items}) async {
    List itemIDList = items.keys.toList(growable: false);
    List quantityList = items.values.toList(growable: false);

    for (int i = 0; i < itemIDList.length; i++) {
      addQuantity(itemID: itemIDList[i], quantity: quantityList[i]);
    }
  }

  void addNewItem({
    required final int itemID,
    required final int quantity,
  }) async {
    await _supabaseClient.from(pharmacyTableName).insert({
      SqlNamePharmacyTable.itemID: itemID,
      SqlNamePharmacyTable.quantity: quantity,
    }).execute();
  }

  void removeQuantity({
    required final String itemID,
    required final int quantity,
  }) async {
    final curTemp = await _supabaseClient
        .from(pharmacyTableName)
        .select(SqlNamePharmacyTable.quantity)
        .eq(SqlNamePharmacyTable.itemID, itemID)
        .execute();

    int currentItemQuantity = curTemp.data[0][SqlNamePharmacyTable.quantity];
    final int finalQuantity = currentItemQuantity - quantity;

    await _supabaseClient
        .from(pharmacyTableName)
        .update({SqlNamePharmacyTable.quantity: finalQuantity})
        .eq(SqlNamePharmacyTable.itemID, itemID)
        .execute();
  }

  void removeMultipleQuantities({required final Map<String, int> items}) async {
    List itemIDList = items.keys.toList(growable: false);
    List quantityList = items.values.toList(growable: false);

    for (int i = 0; i < itemIDList.length; i++) {
      removeQuantity(itemID: itemIDList[i], quantity: quantityList[i]);
    }
  }

  Future<bool> checkItemExistence({required final int itemID}) async {
    PostgrestResponse<dynamic> response = await _supabaseClient
        .from(pharmacyTableName)
        .select(SqlNamePharmacyTable.quantity)
        .eq(SqlNamePharmacyTable.itemID, itemID)
        .execute();

    if (response.data.isEmpty) return false;
    return true;
  }
}

// TO-DO:
// 1. add plpgsql funciton to check existence and add/subtract stock of multiple items
// 2. remind sahej to make a trigger that creates a pharmacy table
// 3. remind costPrice to sahej during DB work