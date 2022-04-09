import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eqaila_app/bloc/shareholderPurchases/shareholder_purchases_bloc.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/utils/strings.dart';
import 'package:eqaila_app/widgets/shareholder_item.dart';

import '../../AppTheme.dart';
import 'search_invoices_screen.dart';

class ShareholderPurchasesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context) as PreferredSizeWidget?,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<ShareholderPurchasesBloc, ShareholderPurchasesState>(
          builder: (context, state) {
            if (state is ShareholderPurchasesLoading) {
              return AppTheme.showLoadingSpinKit();
            } else if (state is ShareholderPurchasesLoaded) {
              if (state.model == null) {
                return noPurchasesWidget();
              } else {
                return purchasesListViewWidget(state.model);
              }
            } else if (state is ShareholderPurchasesError) {
              return Text(state.errorMessage);
            } else {
              return AppTheme.showLoadingSpinKit();
            }
          },
        ),
      ),
    );
  }

  /// AppBar Widget
  Widget appBarWidget(BuildContext context) => AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          Strings.shareholderBills,
          style: AppTheme.appBarStyle,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(Strings.Search, style: AppTheme.textStyleWhite16w600),
            onPressed: () => toSearchInvoicesScreen(context),
          ),
        ],
      );

  /// ListView Widget
  Widget purchasesListViewWidget(List<ShareholderPurchasesModel> model) =>
      ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ShareholderItem(
            model: model[index],
          );
        },
        itemCount: model.length,
      );

  /// no Purchases Widget
  Widget noPurchasesWidget() => Center(
        child: Text(
          Strings.noInvoicesRegistered,
          style: AppTheme.textStyleBlack22w600,
        ),
      );

  /// Navigate To toSearchInvoicesScreen
  void toSearchInvoicesScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return SearchInvoicesScreen();
      }),
    );
  }
}
