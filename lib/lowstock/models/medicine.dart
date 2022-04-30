class Medicine {
  final String medicineName;
  final int stock;

  const Medicine({
    required this.medicineName,
    required this.stock,
  });

  Medicine copy({
    String? medicineName,
    int? stock,
  }) =>
      Medicine(
        medicineName: medicineName ?? this.medicineName,
        stock: stock ?? this.stock,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Medicine &&
              runtimeType == other.runtimeType &&
              medicineName == other.medicineName &&
              stock == other.stock;

  @override
  int get hashCode => medicineName.hashCode ^ stock.hashCode;

  
}