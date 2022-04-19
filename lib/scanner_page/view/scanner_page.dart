import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/scanner_bloc.dart';
import '../widgets/widgets.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner')),
      body: BlocProvider<ScannerBloc>(
        create: (context) => ScannerBloc(),
        child: const Scanner(),
      ),
    );
  }
}
