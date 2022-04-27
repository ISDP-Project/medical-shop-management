import 'package:supabase/supabase.dart';

import './constants.dart';

class MasterDBHandler {
  SupabaseClient _supabase;

  MasterDBHandler(this._supabase);

  Future<List> getMedicine() async {
    final PostgrestResponse response =
        await _supabase.from(SqlNameMedicineTable.tableName).select().execute();
    print(response);
    final dataList = response.data as List<dynamic>;
    return dataList;
  }

  void addMedicine(int barcodeNumber, String medName, String medType,
      int medQuantity, int medPrice, String medDescription) async {
    final PostgrestResponse response =
        await _supabase.from(SqlNameMedicineTable.tableName).insert({
      SqlNameMedicineTable.barcodeNumber: barcodeNumber,
      SqlNameMedicineTable.medName: medName,
      SqlNameMedicineTable.medType: medType,
      SqlNameMedicineTable.medQuantity: medQuantity,
      SqlNameMedicineTable.medPrice: medPrice,
      SqlNameMedicineTable.medDescription: medDescription
    }).execute();
    print(response);
  }

  void updateMedicine(int barcodeNumber, int medQuantity, int medPrice) async {
    final PostgrestResponse response = await _supabase
        .from(SqlNameMedicineTable.tableName)
        .update({
          SqlNameMedicineTable.medQuantity: medQuantity,
          SqlNameMedicineTable.medPrice: medPrice
        })
        .eq(SqlNameMedicineTable.barcodeNumber, barcodeNumber)
        .execute();
    print(response);
  }
}
