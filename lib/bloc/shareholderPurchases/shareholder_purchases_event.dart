part of 'shareholder_purchases_bloc.dart';

@immutable
abstract class ShareholderPurchasesEvent {}

class GetAllShareholderPurchases extends ShareholderPurchasesEvent {
  final String membershipI;
  GetAllShareholderPurchases(this.membershipI);
}

class GetPurchasesListByDate extends ShareholderPurchasesEvent {
  final String? customerId;
  final String? fromDate;
  final String? toDate;
  GetPurchasesListByDate({this.customerId, this.fromDate, this.toDate});
}

class GetSingleInvoices extends ShareholderPurchasesEvent {
  final int? serverKey;

  GetSingleInvoices({this.serverKey});
}
