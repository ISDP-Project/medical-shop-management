part of 'bill_bloc.dart';

abstract class BillState extends Equatable {
  const BillState(
      this.medicines, this.itemsInBill, this.stagedItems, this.totalPrice);

  final List<Medicine>? medicines;
  final Map<Medicine, int>? itemsInBill;
  final Map<Medicine, int>? stagedItems;
  final double? totalPrice;

  @override
  List<Object?> get props => [itemsInBill, stagedItems, medicines];
}

class BillStateInitial extends BillState {
  const BillStateInitial() : super(null, null, null, null);
}

class BillStateLoading extends BillState {
  const BillStateLoading({
    List<Medicine>? medicines,
    Map<Medicine, int>? itemsInBill,
    Map<Medicine, int>? stagedItems,
    double? totalPrice,
  }) : super(medicines, itemsInBill ?? const {}, stagedItems ?? const {},
            totalPrice ?? 0);
}

class BillStateError extends BillState {
  const BillStateError() : super(null, null, null, null);
}

class BillStateLoaded extends BillState {
  const BillStateLoaded({
    required List<Medicine> medicines,
    Map<Medicine, int>? itemsInBill,
    Map<Medicine, int>? stagedItems,
    double? totalPrice,
  }) : super(
          medicines,
          itemsInBill ?? const {},
          stagedItems ?? const {},
          totalPrice ?? 0,
        );
}
