import 'package:supabase/supabase.dart';

class PharmacyDataRepository {
  final SupabaseClient _supabaseClient;
  final String
      pharmacyTableName; // table name: 'gstin_' + pharmacyGSTIN (name: gstin_abc12def345, pharmacyGSTIN: abc12def345)
  PharmacyDataRepository(this._supabaseClient, this.pharmacyTableName);

  void addQuantity({
    required final String itemID,
    required final int quantity,
  }) async {
    if ((await checkItemExistence(itemID: itemID)) == false) {
      addNewItem(itemID: itemID, quantity: quantity);
    } else {
      final curTemp = await _supabaseClient
          .from(pharmacyTableName)
          .select('quantity')
          .eq('item_id', itemID)
          .execute();

      int currentItemQuantity = curTemp.data[0]['quantity'];
      final int finalQuantity = quantity + currentItemQuantity;

      await _supabaseClient
          .from(pharmacyTableName)
          .update({'quantity': finalQuantity})
          .eq('item_id', itemID)
          .execute();
    }
  }

  void addMultipleQuantities({required final Map<int, int> items}) async {
    // ON-PURCHASE // if multiple items scanned together
    // write code here. Do by 2:30 PM meet tomorrow
    // from(pharmacyTableName).up
    // items.update()
  }

  void addNewItem({
    required final String itemID,
    required final int quantity,
  }) async {
    await _supabaseClient
        .from(pharmacyTableName)
        .insert({'item_id': itemID, 'quantity': quantity}).execute();
  }

  void removeQuantity({
    required final String itemID,
    required final int quantity,
  }) async {
    final curTemp = await _supabaseClient
        .from(pharmacyTableName)
        .select('quantity')
        .eq('item_id', itemID)
        .execute();

    int currentItemQuantity = curTemp.data[0]['quantity'];
    final int finalQuantity = currentItemQuantity - quantity;

    await _supabaseClient
        .from(pharmacyTableName)
        .update({'quantity': finalQuantity})
        .eq('item_id', itemID)
        .execute();
  }

  void removeMultipleQuantities({required final Map<int, int> items}) async {
    // write code here
  }

  Future<bool> checkItemExistence({required final String itemID}) async {
    PostgrestResponse<dynamic> response = await _supabaseClient
        .from(pharmacyTableName)
        .select('quantity')
        .eq('item_id', itemID)
        .execute();

    if (response.data.isEmpty) return false;
    return true;
  }
}
// addMultipleQuantities
// removeMultipleQuantities
// test all functions
// remind sahej to make a trigger that creates a pharmacy table
// remind costPrice to sahej during DB work