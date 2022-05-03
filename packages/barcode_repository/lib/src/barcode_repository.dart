import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:supabase/supabase.dart';

import './constants.dart';
import './models/models.dart';

class BarcodeRepository {
  final SupabaseClient _supabase;
  final String _upcApiKey;
  final String _apiUrl = 'https://api.upcdatabase.org/';
  final String _searchKey = 'search/';
  final String _lookupKey = 'product/';

  List<ScannedBarcodeItem>? _dbResults;

  BarcodeRepository({required String apiKey, required SupabaseClient supabase})
      : _upcApiKey = '?apikey=$apiKey',
        _supabase = supabase;

  Future<List<ScannedBarcodeItem>?> getItems(
    String barcodeId, {
    int shortenBy = 4,
  }) async {
    ScannedBarcodeItem? result = await _tryGetMedicineFromDb(barcodeId);

    if (result != null) return [result];

    result = await _tryLookup(barcodeId);

    if (result != null) return [result];

    return await _trySearch(barcodeId, shortenBy);
  }

  void addItemToLocalCopy(ScannedBarcodeItem item) {
    _dbResults!.add(item);
  }

  Future<ScannedBarcodeItem?> _tryLookup(String barcodeId) async {
    final response =
        await http.get(Uri.parse('$_apiUrl$_lookupKey$barcodeId$_upcApiKey'));

    final data = jsonDecode(response.body);
    bool isSuccess = data[UpcApiResponseNames.success];

    if (!isSuccess) return null;

    return ScannedBarcodeItem(
        name: data[UpcApiResponseNames.name], barcodeId: barcodeId);
  }

  Future<List<ScannedBarcodeItem>?> _trySearch(
    String barcodeId,
    int shortenBy,
  ) async {
    final String shortenedBarcodeId =
        barcodeId.substring(0, barcodeId.length - shortenBy);

    final response = await http.get(Uri.parse(
      '$_apiUrl$_searchKey$shortenedBarcodeId$_upcApiKey',
    ));

    final data = jsonDecode(response.body);
    bool isSuccess = data[UpcApiResponseNames.success];

    log(response.body);

    if (!isSuccess) return null;

    List<ScannedBarcodeItem> results = [];
    int resultsLength = data[UpcApiResponseNames.resultsLength];
    final dataList = data[UpcApiResponseNames.itemsList];

    for (int i = 0; i < resultsLength; i++) {
      results.add(ScannedBarcodeItem(
        name: dataList[i][UpcApiResponseNames.name],
        barcodeId: barcodeId,
      ));
    }

    if (results.isEmpty) return null;

    return results;
  }

  Future<ScannedBarcodeItem?> _tryGetMedicineFromDb(String barcodeId) async {
    if (_dbResults != null) {
      log('DB RES: $_dbResults');
      ScannedBarcodeItem result = _dbResults!.firstWhere(
        (element) => element.barcodeId == barcodeId,
        orElse: () => ScannedBarcodeItem(name: '_', barcodeId: '_'),
      );

      if (result.barcodeId == '_') return null;

      return result;
    }

    final PostgrestResponse response =
        await _supabase.from(SqlNameMedicineTable.tableName).select().execute();

    if (response.hasError) return null;

    _dbResults = [];
    for (int i = 0; i < response.data.length; i++) {
      // log(response.data[i][SqlNameMedicineTable.medMrp].runtimeType.toString());
      _dbResults!.add(ScannedBarcodeItem(
        name: response.data[i][SqlNameMedicineTable.medSaltName],
        barcodeId:
            response.data[i][SqlNameMedicineTable.barcodeNumber].toString(),
        manufacturer: response.data[i][SqlNameMedicineTable.manufacturer],
        mrp: double.parse(
            response.data[i][SqlNameMedicineTable.medMrp].toString()),
        type: response.data[i][SqlNameMedicineTable.medType],
        foundLocally: true,
      ));
    }

    return _tryGetMedicineFromDb(barcodeId);
  }
}
