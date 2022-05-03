import 'dart:developer';

import 'package:supabase/supabase.dart';

import './constants.dart';

class MasterDBHandler {
  SupabaseClient _supabase;

  MasterDBHandler(this._supabase);

  Future<List> getMedicineRow() async {
    final PostgrestResponse response =
        await _supabase.from(SqlNameMedicineTable.tableName).select().execute();
    // print(response.data);
    final dataList = response.data as List<dynamic>;
    return dataList;
  }

  Future<PostgrestResponse> getManufaturer(int barcodeNumber) async {
    final PostgrestResponse response = await _supabase
        .from(SqlNameMedicineTable.tableName)
        .select(SqlNameMedicineTable.manufacturer)
        .eq(SqlNameMedicineTable.barcodeNumber, barcodeNumber)
        .execute();
    // print(response.data);
    return response;
  }

  Future<PostgrestResponse> getSaltName(int barcodeNumber) async {
    final PostgrestResponse response = await _supabase
        .from(SqlNameMedicineTable.tableName)
        .select(SqlNameMedicineTable.medSaltName)
        .eq(SqlNameMedicineTable.barcodeNumber, barcodeNumber)
        .execute();
    // print(response.data);
    return response;
  }

  Future<PostgrestResponse> getMrp(int barcodeNumber) async {
    final PostgrestResponse response = await _supabase
        .from(SqlNameMedicineTable.tableName)
        .select(SqlNameMedicineTable.medMrp)
        .eq(SqlNameMedicineTable.barcodeNumber, barcodeNumber)
        .execute();
    // print(response.data);
    return response;
  }

  Future<void> addMedicine({
    required String barcodeId,
    required String medSaltName,
    required int medType,
    required double mrp,
    required String manufacturer,
  }) async {
    final PostgrestResponse response =
        await _supabase.from(SqlNameMedicineTable.tableName).insert({
      SqlNameMedicineTable.barcodeNumber: barcodeId,
      SqlNameMedicineTable.medSaltName: medSaltName,
      SqlNameMedicineTable.medType: medType,
      SqlNameMedicineTable.medMrp: mrp,
      SqlNameMedicineTable.manufacturer: manufacturer,
    }).execute();
    log('PUSH DATA: ${response.data}');
    log('PUSH ERROR: ${response.error}');
  }

  void updateMedicine(int barcodeNumber, int medMrp) async {
    final PostgrestResponse response = await _supabase
        .from(SqlNameMedicineTable.tableName)
        .update({SqlNameMedicineTable.medMrp: medMrp})
        .eq(SqlNameMedicineTable.barcodeNumber, barcodeNumber)
        .execute();
    // print(response);
  }
}
