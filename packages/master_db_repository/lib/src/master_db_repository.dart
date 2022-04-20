import 'package:supabase/supabase.dart';

class MasterDBHandler {

  SupabaseClient _supabase;

  MasterDBHandler(this._supabase);

  readMedicine() async {
    var response = await _supabase.from("Medicine").select().execute();
    print(response);
    final dataList = response.data as List<dynamic>;
    return dataList;
  }

  void addMedicine(int barcodeNumber, String medName, String medType, int medQuantity,
      int medPrice, String medDescription) async {
    var response = await _supabase.from("Medicine").insert({
      'med_id': barcodeNumber,
      'med_name': medName,
      'med_type': medType,
      'med_quantity': medQuantity,
      'med_price': medPrice,
      'med_description': medDescription
    }).execute();
    print(response);
  }

  void updateMedicine(int barcodeNumber, int medQuantity, int medPrice) async {
    var response = _supabase
        .from("Medicine")
        .update({'med_Quantity': medQuantity, 'med_Price': medPrice})
        .eq('med_id', barcodeNumber)
        .execute();
    print(response);
  }
}
