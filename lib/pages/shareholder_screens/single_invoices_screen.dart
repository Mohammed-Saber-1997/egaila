import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eqaila_app/bloc/shareholderPurchases/shareholder_purchases_bloc.dart';
import 'package:eqaila_app/models/salesInvoice/details.dart';
import 'package:eqaila_app/models/salesInvoice/get_sales_invoice_by_server_key_model.dart';
import 'package:eqaila_app/utils/date_time_utils.dart';
import 'package:eqaila_app/utils/strings.dart';

import '../../AppTheme.dart';

class SingleInvoicesScreen extends StatelessWidget {
  final int? serverKey;

  SingleInvoicesScreen({this.serverKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          Strings.InvoiceDetails,
          style: AppTheme.appBarStyle,
        ),
      ),
      body: BlocBuilder<ShareholderPurchasesBloc, ShareholderPurchasesState>(
        builder: (context, state) {
          if (state is SingleInvoicesLoading) {
            return AppTheme.showLoadingSpinKit();
          } else if (state is SingleInvoicesLoaded) {
            return baseScreenWidget(state.model);
          } else if (state is SingleInvoicesError) {
            return Center(
              child: Text(
                Strings.noInvoiceDetails,
                style: AppTheme.textStyleDark16w600,
              ),
            );
          } else {
            return AppTheme.showLoadingSpinKit();
          }
        },
      ),
    );
  }

  /// base Screen Widget
  Widget baseScreenWidget(GetSalesInvoiceByServerKeyModel model) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Column(
          children: <Widget>[
            headerWidget(model),
            SizedBox(height: 30.0),
            listViewWidget(model),
          ],
        ),
      ),
    );
  }

  /// header Widget
  Widget headerWidget(GetSalesInvoiceByServerKeyModel model) => Container(
        decoration: ShapeDecoration(
          color: AppTheme.buttonsColor,
          shadows: AppTheme.shadows,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'الموقع: ${model.locationName}',
                      style: AppTheme.textStyleWhite16w600,
                    ),
                    Text(
                      'تاريخ الفاتوره: ${DateTimeUtils.convertDateFromString(model.writtenAt!)}',
                      style: AppTheme.textStyleWhite16w600,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'رقم الفاتوره: ',
                          style: AppTheme.textStyleWhite16w600,
                        ),
                        Expanded(
                          child: Text(
                            '${model.invoiceID}',
                            style: AppTheme.textStyleWhite16w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(Strings.total, style: AppTheme.textStyleOrange20w700),
                  Text(
                    '${model.invoiceTotalAmount}',
                    style: AppTheme.textStyleOrange20w700,
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ],
          ),
        ),
      );

  /// list View Widget
  Widget listViewWidget(GetSalesInvoiceByServerKeyModel model) => Expanded(
        flex: 1,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index == model.details!.length) {
              return paymentDetailsWidget(model);
            }
            if (index == model.details!.length + 1) {
              return operationDetailsWidget(model);
            } else {
              return baseListViewItem(context, model.details![index],
                  background: AppTheme.extraDarkPurple);
            }
          },
          itemCount: model.details!.length + 2,
        ),
      );

  /// base List View Item
  Widget baseListViewItem(BuildContext context, Details detail,
          {Color? background}) =>
      Container(
        width: MediaQuery.of(context).size.width - 20,
        margin: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Text(detail.itemShortDescription!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppTheme.buttonsColor,
                            fontSize: 16,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.bold)),
                  ),
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: background,
                  ),
                  SizedBox(width: 5),
                  Text('د ك ${detail.totalItemPrice}',
                      style: AppTheme.textStyleOrange16w700),
                  SizedBox(width: 10)
                ],
              ),
            ),
            Text('الكميه: ${detail.qty}', style: AppTheme.textStyleGray13w600),
            SizedBox(height: 15),
            Divider(color: AppTheme.gg),
          ],
        ),
      );

  /// payment Details Widget
  Widget paymentDetailsWidget(GetSalesInvoiceByServerKeyModel model) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: AppTheme.buttonsColor,
            shadows: AppTheme.shadows,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(Strings.paymentDetails,
                    style: AppTheme.textStyleWhite20Bold),
              ),
              SizedBox(height: 10),
              Divider(
                height: 1,
                color: AppTheme.grey,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${model.invoiceTotalAmount}',
                      style: AppTheme.textStyleOrange20Bold),
                  Text(model.payments![0].paymentTypeName!,
                      style: AppTheme.textStyleOrange20Bold),
                ],
              )
            ],
          ),
        ),
      );

  /// operation Details Widget
  Widget operationDetailsWidget(GetSalesInvoiceByServerKeyModel model) =>
      Container(
        decoration: ShapeDecoration(
          color: AppTheme.appBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.0),
              Text(Strings.operationDetails,
                  style: AppTheme.textStyleDark18Bold),
              Divider(
                height: 1,
                color: AppTheme.greyO,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BarcodeWidget(
                  height: 100,
                  barcode: Barcode.code128(),
                  data: '${model.serveRKEY}',
                ),
              ),
            ],
          ),
        ),
      );
}
