import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(const ScannerState(items: [])) {
    on<ScannerEventScannerToggleRequested>(_toggleScanner);
    on<ScannerEventBarcodeScanned>(_onBarcodeScanned);
    // on<ScannedBarcodeToMedicine>(_finalFetch);
  }

  void _toggleScanner(
      ScannerEventScannerToggleRequested event, Emitter<ScannerState> emit) {
    if (state.showScannerWidget) {
      emit(ScannerState(items: state.items, showScannerWidget: false));
    } else {
      emit(ScannerState(items: state.items, showScannerWidget: true));
    }
  }

  void _onBarcodeScanned(
      ScannerEventBarcodeScanned event, Emitter<ScannerState> emit) async {
    if (event.barcodeId != null) {
      log('BARCODE ID: ${event.barcodeId}');
      // String medicineName = await _fetchMedicineName(event.barcodeId ?? '');
      String medicineName = await _fetchMedicineName(event.barcodeId ?? '');
      log('MEDICINE NAME: $medicineName');
      List<String> newList = [...state.items];

      newList.add(medicineName);
      emit(ScannerState(
        items: newList,
        showScannerWidget: state.showScannerWidget,
      ));
    }
  }

  Future<String> _fetchMedicineName(String barcodeId) async {
    final response = await http.get(Uri.parse(
        'https://api.barcodelookup.com/v3/products?barcode=$barcodeId&formatted=y&key=wh1xhsh2dnbs4w26bee5j4z1esme5m'));

    print('API RESPONSE: ${response.statusCode}');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (jsonDecode(response.body)['products'][0]['title']) as String;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
}
