import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:master_db_repository/master_db_repository.dart';

import 'package:recase/recase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:barcode_repository/barcode_repository.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

import '../widgets/widgets.dart';
import '../bloc/scanner_bloc.dart';
import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScannerBloc>(
      create: (context) => ScannerBloc(
        barcodeRepository: context.read<BarcodeRepository>(),
        pharmacyDataRepository: context.read<PharmacyDataRepository>(),
        masterDBHandler: context.read<MasterDBHandler>(),
      ),
      child: ScannerPageView(),
    );
  }
}

class ScannerPageView extends StatelessWidget {
  DateTime? lastScan;
  ScannerPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ScannerPageConstants.appBarHeading),
        elevation: kDefaultAppBarElevation,
        actions: [
          IconButton(
            onPressed: () {
              try {
                context
                    .read<ScannerBloc>()
                    .add(const ScannerEventAddStockToDatabaseRequested());
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(ScannerPageConstants.snackBarErrorMessage),
                  ),
                );
              }
            },
            icon: const Icon(Icons.save_sharp),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              vertical: kDefaultMargin * 2, horizontal: kDefaultMargin * 1.25),
          child: BlocBuilder<ScannerBloc, ScannerState>(
            builder: (context, state) {
              if (state is ScannerStateLoading) {
                return Center(
                  child: SpinKitDualRing(
                    color: Theme.of(context).colorScheme.primary,
                    size: kDefaultLoadingIndicatorSize,
                  ),
                );
              }

              if (state is ScannerStateUserInput) {
                TextEditingController _barcodeController =
                    TextEditingController(
                  text: state.inputRequestingItem?.barcodeId ?? '',
                );
                TextEditingController _nameController = TextEditingController(
                  text: state.inputRequestingItem?.name?.titleCase ?? '',
                );
                TextEditingController _mrpController = TextEditingController(
                  text: (state.inputRequestingItem?.mrp ?? '').toString(),
                );
                TextEditingController _manufacturerController =
                    TextEditingController(
                  text: state.inputRequestingItem?.manufacturer ?? '',
                );

                return UserInputForm(
                  barcodeController: _barcodeController,
                  nameController: _nameController,
                  manufacturerController: _manufacturerController,
                  mrpController: _mrpController,
                );
              }

              if (state is ScannerStateScannedItemSelector) {
                return ItemSelector(
                  state: state,
                );
              }

              return Column(
                children: [
                  BlocSelector<ScannerBloc, ScannerState, bool>(
                    selector: (state) {
                      return state.showScannerWidget;
                    },
                    builder: (context, showScanner) {
                      if (showScanner) {
                        return Expanded(
                          flex: 45,
                          child: SizedBox(
                            height: double.infinity,
                            child: MobileScanner(
                              allowDuplicates: false,
                              fit: BoxFit.fitWidth,
                              controller: MobileScannerController(
                                facing: CameraFacing.back,
                                torchEnabled: false,
                              ),
                              onDetect: (barcode, args) {
                                if (lastScan == null ||
                                    DateTime.now()
                                        .subtract(const Duration(seconds: 2))
                                        .isAfter(lastScan!)) {
                                  lastScan = DateTime.now();
                                  context.read<ScannerBloc>().add(
                                      ScannerEventBarcodeScanned(
                                          barcode.rawValue));
                                  log('Barcode found! ${barcode.rawValue} of type: ${barcode.rawValue.runtimeType}');
                                }
                              },
                            ),
                          ),
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                  const Expanded(
                    flex: 55,
                    child: ScannedItemsListView(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<ScannerBloc, ScannerState>(
        builder: (context, state) {
          if (state is ScannerStateNormal || state is ScannerStateInitial) {
            return FloatingActionButton(
              child: Icon(
                Icons.qr_code,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              onPressed: () {
                context
                    .read<ScannerBloc>()
                    .add(const ScannerEventScannerToggleRequested());
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class UserInputForm extends StatelessWidget {
  const UserInputForm({
    Key? key,
    required TextEditingController barcodeController,
    required TextEditingController nameController,
    required TextEditingController manufacturerController,
    required TextEditingController mrpController,
  })  : _barcodeController = barcodeController,
        _nameController = nameController,
        _manufacturerController = manufacturerController,
        _mrpController = mrpController,
        super(key: key);

  final TextEditingController _barcodeController;
  final TextEditingController _nameController;
  final TextEditingController _manufacturerController;
  final TextEditingController _mrpController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ScannerPageConstants.editingStateHeading,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          ScannerPageConstants.editingStateSubheading,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              CustomTextField(
                label: ScannerPageConstants.barcodeEditingFieldLabel,
                controller: _barcodeController,
                textInputType: TextInputType.number,
              ),
              CustomTextField(
                label: ScannerPageConstants.nameEditingFieldLabel,
                controller: _nameController,
              ),
              CustomTextField(
                label: ScannerPageConstants.manufacturerEditingFieldLabel,
                controller: _manufacturerController,
              ),
              CustomTextField(
                label: ScannerPageConstants.mrpEditingFieldLabel,
                controller: _mrpController,
                textInputType: TextInputType.number,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                onPressed: () {
                  if (_barcodeController.text.isNotEmpty &&
                      _nameController.text.isNotEmpty &&
                      _manufacturerController.text.isNotEmpty &&
                      _mrpController.text.isNotEmpty) {
                    context.read<ScannerBloc>().add(
                          ScannerEventItemStagingRequested(
                            item: ScannedBarcodeItem(
                              barcodeId: _barcodeController.text,
                              name: _nameController.text,
                              manufacturer: _manufacturerController.text,
                              mrp: double.parse(_mrpController.text),
                              type: 1,
                            ),
                          ),
                        );
                  }
                },
                label: ScannerPageConstants.editingDoneButtonLabel,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ItemSelector extends StatelessWidget {
  const ItemSelector({
    Key? key,
    required this.state,
  }) : super(key: key);

  final ScannerState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ScannerPageConstants.productChoiceHeading,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          ScannerPageConstants.productChoiceSubheading,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: kDefaultPadding),
        ),
        Expanded(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.scannedPotentialItems?.length ?? 0,
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: kDefaultMargin * 0.75,
                  ),
                  child: CustomElevatedButton(
                    label: state.scannedPotentialItems![i].name!.titleCase,
                    labelAlignment: Alignment.centerLeft,
                    onPressed: () {
                      context.read<ScannerBloc>().add(
                            ScannerEventMakeChoice(
                              chosenItem: state.scannedPotentialItems![i],
                            ),
                          );
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.labelAlignment = Alignment.center,
  }) : super(key: key);

  final String label;
  final Alignment labelAlignment;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding * 1.5,
        ),
        child: Align(
          alignment: labelAlignment,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
      ),
    );
  }
}
