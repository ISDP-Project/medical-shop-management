class ScannedBarcodeItem {
  final String? name;
  final String? barcodeId;
  final int? type;
  final double? mrp;
  final String? manufacturer;
  final bool foundLocally;

  const ScannedBarcodeItem({
    required this.name,
    required this.barcodeId,
    this.type,
    this.mrp,
    this.manufacturer,
    this.foundLocally = false,
  });

  bool anyNull() {
    return name == null ||
        barcodeId == null ||
        type == null ||
        mrp == null ||
        manufacturer == null;
  }

  @override
  String toString() {
    return '($name, $manufacturer, $barcodeId)';
  }
}
