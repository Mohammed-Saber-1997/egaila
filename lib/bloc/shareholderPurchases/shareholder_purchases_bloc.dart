import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/models/salesInvoice/get_sales_invoice_by_server_key_model.dart';
import 'package:eqaila_app/repository/shareholder/shareholder_purchases_repository.dart';

part 'shareholder_purchases_event.dart';
part 'shareholder_purchases_state.dart';

class ShareholderPurchasesBloc
    extends Bloc<ShareholderPurchasesEvent, ShareholderPurchasesState> {
  final ShareholderPurchasesRepository repository;
  ShareholderPurchasesBloc(this.repository)
      : super(ShareholderPurchasesInitial());

  @override
  Stream<ShareholderPurchasesState> mapEventToState(
    ShareholderPurchasesEvent event,
  ) async* {
    if (event is GetAllShareholderPurchases) {
      yield ShareholderPurchasesLoading();
      try {
        List<ShareholderPurchasesModel> model =
            await repository.getShareholderPurchasesList(event.membershipI);

        yield ShareholderPurchasesLoaded(model);
      } catch (error) {
        yield ShareholderPurchasesError(error.toString());
      }
    }
    if (event is GetPurchasesListByDate) {
      yield ShareholderPurchasesLoading();
      try {
        List<ShareholderPurchasesModel> model =
            await repository.getPurchasesListByDate(
                event.customerId, event.fromDate, event.toDate);

        yield ShareholderPurchasesLoaded(model);
      } catch (error) {
        yield ShareholderPurchasesError(error.toString());
      }
    }
    if (event is GetSingleInvoices) {
      yield SingleInvoicesLoading();
      try {
        GetSalesInvoiceByServerKeyModel model = await repository
            .getSalesInvoiceByServerKey(event.serverKey.toString());
        print('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
        yield SingleInvoicesLoaded(model);
      } catch (error) {
        yield SingleInvoicesError(error.toString());
      }
    }
  }
}
