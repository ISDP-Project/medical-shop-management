import 'package:supabase/supabase.dart';

class PharmacyDBApi {
  final SupabaseClient _supabaseClient;
  final String pharmacyUserID;
  final String entryBarcodeID;
  final String
      exitBarcodeID; // ALL PARAMETERS REQUIRED OR WHAT IF YES THEN PASS INTO FXNS DIRECTLY INSTEAD  (some some to fucntions add some to class)
  final int quantityAdded;
  final int
      quantityDeducted; // CHECK IF ALREADY IN DATABASE AND CALL ACCORDINGLY, ADDQUANTITY OR ADDITEM

  PharmacyDBApi(this._supabaseClient, this.pharmacyUserID, this.entryBarcodeID,
      this.exitBarcodeID, this.quantityAdded, this.quantityDeducted);

  createNewPharmacyTable() {}

  addQuantityToInventory() async {
    // if med already exists in pharmacy database // ON-NEW-PURCHASE
    final curTemp = await _supabaseClient
        .from(pharmacyUserID)
        .select('quantity')          // find quantity us id ka
        .execute(); // pharmacyUserID = name of table of that pharmacy
    int currentItemQuantity = curTemp.data();
    final finalQuantity = quantityAdded + currentItemQuantity;

    await _supabaseClient
        .from(pharmacyUserID)
        .update({
          'quantity': finalQuantity
        }) // if doesnt work, convert finalQuantity to String
        .eq('Barcode_ID', entryBarcodeID)
        .execute();
  }

  removeQuantityFromInventory() async {
    final curTemp = await _supabaseClient
        .from(pharmacyUserID)
        .select('quantity')
        .execute();
    int currentItemQuantity = curTemp.data();
    final finalQuantity = currentItemQuantity - quantityDeducted;

    await _supabaseClient
        .from(pharmacyUserID)
        .update({
          'quantity': finalQuantity
        }) // if doesnt work, convert finalQuantity to String
        .eq('Barcode_ID', exitBarcodeID)
        .execute();
  }

  addItemToInventory() async {
    // https://www.youtube.com/watch?v=fqfHEZvQPlY
    // vv if doesnt work then convert quantity to string idk vv
    await _supabaseClient.from(pharmacyUserID).insert([
      {'Barcode_ID': entryBarcodeID},
      {'quantity': quantityAdded}
    ]).execute(); // HOW TO ADD TO OTHER FIELDS (cost price also)? (info would be in main database like name etc)
  }
}



// add Cost Price to table
// cost price parameter
// make sample table in supabase

// underscore barcode id

// MAYBE IDK:

//  at login,
//           can update table via barcode

//  at signup (new user)
//           creates new table for pharmacy


// if not returning enything, do 'return type = void'


// figure out Barcode_ID table vala thing wit palash main database pe dede id basically aisa kuch