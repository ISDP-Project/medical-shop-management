import 'package:supabase/supabase.dart';

class PharmacyDataRepository {
  final SupabaseClient _supabaseClient;
  final String
      pharmacyTableName; // table name: 'gstin_' + pharmacyGSTIN (name: gstin_abc12def345, pharmacyGSTIN: abc12def345)
  PharmacyDataRepository(this._supabaseClient, this.pharmacyTableName);

  void addQuantity({
    // ON-PURCHASE // if item already exists in database, update quantity
    required final String itemID, // itemID: int
    required final int quantity,
  }) async {
    if ((await checkItemExistence(itemID: itemID)) == false) {
      addNewItem(itemID: itemID, quantity: quantity);

    } else {
      final curTemp = await _supabaseClient
          .from(pharmacyTableName)
          .select('quantity')
          .eq('item_id', itemID)
          .execute(); // pharmacyTableName = name of table of that pharmacy

      int currentItemQuantity = curTemp.data[0][
          'quantity']; // #################### this might be wrong, refer to authentication repository
      final int finalQuantity = quantity + currentItemQuantity;

      await _supabaseClient
          .from(pharmacyTableName)
          .update({
            'quantity': finalQuantity
          }) // if doesnt work, convert finalQuantity to String
          .eq('item_id', itemID)
          .execute();
    }
    // if item already in table: ##########################################
    // else: addNewItem({itemID, quantity}) ################################
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
    // if item not in inventory, call this fxn basically
    await _supabaseClient
        .from(pharmacyTableName)
        .insert({'item_id': itemID, 'quantity': quantity}).execute();
  }

  void removeQuantity({
    // ON-SALE
    required final String itemID,
    required final int quantity,
  }) async {
    final curTemp = await _supabaseClient
        .from(pharmacyTableName)
        .select('quantity')
        .eq('item_id', itemID)
        .execute();

    print(curTemp.data);

    int currentItemQuantity = curTemp.data[0]['quantity'];
    final int finalQuantity =
        currentItemQuantity - quantity; // finalQuantity datatype?

    await _supabaseClient
        .from(pharmacyTableName)
        .update({
          'quantity': finalQuantity
        }) // if doesnt work, convert finalQuantity to String
        .eq('item_id', itemID)
        .execute();
  }

  void removeMultipleQuantities({required final Map<int, int> items}) async {
    // ON-SALE // if multiple items scanned together
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



// check item existence
// multipleAdd
// mutlipleRemove
// testing sab functions ki wfjvweyrkwoid,;ekwnifvwehn


/////////////////////////////

// upsert
// check if item already exists or not

// take a list as well

// run code

// change barcode id to med_id and Quantity to quantity

// DML commands likh, DDL will be done db side pe

// run and test this code?
// PLPGSQL some shit udyhewaxyru
// if not returning enything, do 'return type = void'
// remind costPrice to sahej during DB work

// MAYBE IDK:

//  at login,
//           can update table via barcode

//  at signup (new user)
//           creates new table for pharmacy

// palash table med id kya hota hau medicined.id implies id (palashtable colum naming conventions fix)
