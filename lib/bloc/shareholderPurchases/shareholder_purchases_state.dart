part of 'shareholder_purchases_bloc.dart';

@immutable
abstract class ShareholderPurchasesState {
  final GetSalesInvoiceByServerKeyModel? modelSales;

  ShareholderPurchasesState(this.modelSales);
}

class ShareholderPurchasesInitial extends ShareholderPurchasesState {
  ShareholderPurchasesInitial() : super(null);
}

class ShareholderPurchasesLoading extends ShareholderPurchasesState {
  ShareholderPurchasesLoading() : super(null);
}

class ShareholderPurchasesLoaded extends ShareholderPurchasesState {
  final List<ShareholderPurchasesModel> model;
  ShareholderPurchasesLoaded(this.model) : super(null);
}

class ShareholderPurchasesError extends ShareholderPurchasesState {
  final String errorMessage;
  ShareholderPurchasesError(this.errorMessage) : super(null);
}

///______________________

class SingleInvoicesLoading extends ShareholderPurchasesState {
  SingleInvoicesLoading() : super(null);
}

class SingleInvoicesLoaded extends ShareholderPurchasesState {
  final GetSalesInvoiceByServerKeyModel model;
  SingleInvoicesLoaded(this.model) : super(model);
}

class SingleInvoicesError extends ShareholderPurchasesState {
  final String errorMessage;
  SingleInvoicesError(this.errorMessage) : super(null);
}
