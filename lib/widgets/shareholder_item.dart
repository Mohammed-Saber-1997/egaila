import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eqaila_app/bloc/shareholderPurchases/shareholder_purchases_bloc.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/pages/shareholder_screens/single_invoices_screen.dart';
import 'package:eqaila_app/repository/shareholder/shareholder_purchases_repository.dart';
import 'package:eqaila_app/utils/date_time_utils.dart';

import '../AppTheme.dart';
import 'detail_chip.dart';

final Color flightBorderColor = Color(0xFFE6E6E6);

class ShareholderItem extends StatelessWidget {
  final Color? itemBackground;
  final ShareholderPurchasesModel? model;

  ShareholderItem({this.model, this.itemBackground});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return BlocProvider<ShareholderPurchasesBloc>(
              create: (context) =>
                  ShareholderPurchasesBloc(ShareholderPurchasesRepositoryImpl())
                    ..add(GetSingleInvoices(serverKey: model!.serveRKEY)),
              child: SingleInvoicesScreen(serverKey: model!.serveRKEY),
            );
          }),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0, left: 16.0),
              decoration: BoxDecoration(
                color: itemBackground,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                border: Border.all(color: flightBorderColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'الموقع/ ${model!.locationName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                        fontSize: 16.0,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'رقم الفاتورة/ ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Cairo",
                            fontSize: 16.0,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${model!.invoiceID}',
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Cairo",
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'أجمالي الفاتورة/ ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Cairo",
                            fontSize: 18.0,
                          ),
                        ),
                        DetailChip(
                          label: '${model!.invoiceTotalAmount}',
                          textStyle: TextStyle(
                            color: AppTheme.colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Cairo",
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: -8.0,
                      children: <Widget>[
                        DetailChip(
                          textStyle: TextStyle(
                            fontFamily: "Cairo",
                          ),
                          iconData: Icons.calendar_today,
                          label:
                              '${DateTimeUtils.convertDateFromString(model!.writtenAt!)}',
                        ),
                        DetailChip(
                          textStyle: TextStyle(
                            fontFamily: "Cairo",
                          ),
                          iconData: Icons.confirmation_number,
                          label: 'رقم المكينة: ${model!.serveRKEY}',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
